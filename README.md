# Academy Awards SQL

Contributor and merge policy: [AGENTS.md](AGENTS.md). Agents merge completed,
verified work within the approved task. Applying SQL to a database remains a
separate authorized action; merging this repository does not apply it.

A Postgres database of the Academy Awards, ceremonies 1–98 (film years 1927/28–2025).

This is the database only. The Lunara site and the Oscar Ledger plugin stay in their own repositories. Load these two files, in order, into an empty database.

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/0001_oscars.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/0002_lunara.sql
```

`0001` is the finished record, ceremonies 1–98. `0002` is optional. It attaches Lunara film-page ids and poster URLs where the IMDb title id matches. `0003` opens ceremony 99, film year 2026, with no nominations.

## The next ceremony

Ceremony 99 is a real row. Its status is `building`. It has no films and no nominees, because those have not been announced. The home slate stays on the last complete ceremony.

Do not edit `0001` when the season starts. Add the next file, `sql/0004_ceremony_99_nominations.sql`, and insert only what is known: new films, new people, then the nomination and its links. When the ceremony has been held, that same file can set the row to complete:

```sql
update ceremonies set status = 'complete' where number = 99;
```

The year after that is the same move. Insert ceremony 100 as `building` in its own file, and leave it empty until there is something to record.

## Layers

The official ballot is `nominations`. A prediction does not go in that table.

`sql/0004_layers.sql` adds two tables. `layers` names a source: a prediction, a precursor award, or an editorial note. `layer_entries` is one call in that source, pointed at a ceremony and a category. It may name a film or a person who is not in the official record yet.

`sql/predictions.sql` is Dalton's slate. It deletes and reinserts only `layer_id = 1`. Re-run it any time. It cannot change a nomination.

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/0004_layers.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/predictions.sql
```

```sql
select film_year, canonical_name, outcome, film, person
from v_layers
where slug = 'dalton'
order by ceremony_number, canonical_name;
```

## What is in it

| Table | Rows | Holds |
|---|---:|---|
| ceremonies | 98 | One Academy Awards, numbered |
| categories | 66 | Stable award name and class |
| films | 5,265 | One picture, IMDb `tt` id when known |
| entities | 9,613 | 8,404 people, 1,209 companies |
| nominations | 12,137 | One ballot line, 3,515 of them wins |
| nomination_films | 10,879 | Pictures on a nomination, in order |
| nomination_entities | 18,824 | People and companies on a nomination, in order |

A nomination does not store a title or a name. It points at `films` and `entities`. One nomination can name more than one picture, so that link is its own table.

`v_ballots` joins a nomination back into one readable row: year, category, film, nominees, winner.

```sql
select film_year, films, nominees
from v_ballots
where canonical_name = 'BEST PICTURE'
  and winner
order by year_start;
```

## Source

Nomination rows are normalized from [oscar_data](https://github.com/DLu/oscar_data) by David V. Lu!!, a curated scrape of the official Academy Awards Database (awardsdatabase.oscars.org). That dataset is BSD-2-Clause. The copyright and conditions are in `LICENSE` and at the top of `sql/0001_oscars.sql`.

The Lunara columns in `0002` come from the public snapshot at `lunarafilm.com/wp-content/uploads/aat-data/v1/names.json` (built 2026-07-28).
