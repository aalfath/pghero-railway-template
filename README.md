[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/pghero?utm_medium=integration&utm_source=button&utm_campaign=pghero)

# PgHero on Railway

A Railway template for [PgHero](https://github.com/ankane/pghero) 4.1.0, the performance dashboard for Postgres. It's meant as an add-on: you point it at a Postgres you already run on Railway (or anywhere else) and get a dashboard of slow queries, unused and missing indexes, table and index sizes, connections, live queries and maintenance stats.

## What it deploys

| Service | Source | Notes |
| --- | --- | --- |
| PgHero | this repo (`Dockerfile` pins `ankane/pghero:v4.1.0@sha256:9b8f4be0d494655302343b2388c5a3dc6c06ff53489aa78b470123cfd0355a31`) | public domain on port 8080, health check `/health`, basic auth always on |

PgHero keeps no state of its own, so there's no volume and no database in the template.

## Variables

| Variable | Default | What it's for |
| --- | --- | --- |
| `DATABASE_URL` | prompt (the only one) | The Postgres to watch. Deploy into the project that has your database and enter `${{Postgres.DATABASE_URL}}` (or your database service's name instead of `Postgres`), so PgHero connects over the private network. Any `postgres://` URL works too. |
| `PGHERO_USERNAME` | `admin` | Basic auth user. |
| `PGHERO_PASSWORD` | generated | Basic auth password. The service won't start without one. |
| `PORT` | `8080` | Port the dashboard listens on. |

Optional variables you can add later: `PGHERO_STATS_DATABASE_URL` (where historical stats go), `PGHERO_TZ`, `PGHERO_SLOW_QUERY_MS`, `PGHERO_LONG_RUNNING_QUERY_SEC`, `PUMA_WORKERS` (default 0, single mode). See the [PgHero Docker guide](https://github.com/ankane/pghero/blob/master/guides/Docker.md).

## Query stats

The Queries tab needs the `pg_stat_statements` extension. Railway's current Postgres image already preloads it, so press "Enable query stats" on PgHero's Overview page (or run `CREATE EXTENSION pg_stat_statements;`). On another Postgres, add `pg_stat_statements` to `shared_preload_libraries` and restart it first. The rest of the dashboard works without it.

## Updates

Railway notifies everyone who deployed this template when `main` changes. Each change is listed in [CHANGELOG.md](CHANGELOG.md), breaking changes first. You choose when to apply it.

## Files

- `Dockerfile`: the pinned upstream image plus the start script.
- `start.sh`: refuses to start without `PGHERO_PASSWORD`, sets the defaults, then starts Puma. With no `DATABASE_URL`, it serves `setup/config.ru` instead.
- `setup/config.ru`: a tiny page that says how to set `DATABASE_URL` (`/health` still answers 200).

This is a community-maintained deployment package. It isn't affiliated with or endorsed by the PgHero project. PgHero is MIT-licensed.
