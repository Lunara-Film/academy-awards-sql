-- Layers sit on top of the official ballot. They never write nominations.
-- prediction: a person's calls. precursor: another award. editorial: a Lunara pick.
-- The first layer is Dalton's predictions. Rows live in data/predictions.sql
-- and can be re-applied without touching ceremonies 1–98.

create table if not exists layers (
  id    integer primary key,
  kind  text not null check (kind in ('prediction', 'precursor', 'editorial')),
  slug  text not null unique,
  name  text not null,
  note  text
);

insert into layers (id, kind, slug, name, note)
values (
  1,
  'prediction',
  'dalton',
  'Dalton',
  'Personal predictions. Not the official ballot.'
)
on conflict (id) do nothing;

create table if not exists layer_entries (
  id               integer primary key,
  layer_id         integer not null references layers (id),
  ceremony_number  integer not null references ceremonies (number),
  category_id      integer not null references categories (id),
  outcome          text not null check (outcome in ('winner', 'nominee')),
  position         smallint not null default 1,
  film_id          integer references films (id),
  entity_id        integer references entities (id),
  billed_title     text,
  billed_name      text,
  note             text,
  check (
    film_id is not null
    or entity_id is not null
    or billed_title is not null
    or billed_name is not null
  )
);

create index if not exists layer_entries_ceremony_idx
  on layer_entries (layer_id, ceremony_number, category_id);

create or replace view v_layers as
select
  l.kind,
  l.slug,
  l.name as layer_name,
  e.ceremony_number,
  c.film_year,
  c.status as ceremony_status,
  cat.class as award_class,
  cat.canonical_name,
  e.outcome,
  e.position,
  coalesce(f.canonical_title, e.billed_title) as film,
  coalesce(en.canonical_name, e.billed_name) as person,
  e.note
from layer_entries e
join layers l on l.id = e.layer_id
join ceremonies c on c.number = e.ceremony_number
join categories cat on cat.id = e.category_id
left join films f on f.id = e.film_id
left join entities en on en.id = e.entity_id;
