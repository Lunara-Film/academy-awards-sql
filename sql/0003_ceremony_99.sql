-- The 99th Academy Awards, film year 2026.
-- The ceremony exists so the season can be filled in. It has no nominations.
-- Do not edit earlier files. When nominations are announced, add the next
-- SQL file. Set status to 'complete' only after the ceremony has been held.

alter table ceremonies
  add column if not exists status text not null default 'complete';

alter table ceremonies drop constraint if exists ceremonies_status_check;

alter table ceremonies
  add constraint ceremonies_status_check
  check (status in ('complete', 'building'));

insert into ceremonies (number, film_year, year_start, status)
values (99, '2026', 2026, 'building')
on conflict (number) do update
  set film_year = excluded.film_year,
      year_start = excluded.year_start,
      status = excluded.status;
