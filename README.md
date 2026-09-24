# Academy Awards SQL

A Postgres database of the Academy Awards, ceremonies 1–98 (film years 1927/28–2025).

This is the database only. The Lunara site and the Oscar Ledger plugin stay in their own repositories. Load these two files, in order, into an empty database.

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/0001_oscars.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f sql/0002_lunara.sql
```

`0001` is the record. `0002` is optional. It attaches Lunara film-page ids and poster URLs where the IMDb title id matches.

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
