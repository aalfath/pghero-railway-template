#!/bin/sh
# Small wrapper around the official PgHero image for Railway.
set -eu

if [ -z "${DATABASE_URL:-}" ]; then
  echo "pghero-start: DATABASE_URL is empty." >&2
  echo "Set it to the Postgres you want to watch, for example \${{Postgres.DATABASE_URL}}." >&2
  exit 1
fi

# PgHero can kill queries and run EXPLAIN, so never serve it without a login.
if [ -z "${PGHERO_PASSWORD:-}" ]; then
  echo "pghero-start: PGHERO_PASSWORD is empty; refusing to start without basic auth." >&2
  exit 1
fi
export PGHERO_USERNAME="${PGHERO_USERNAME:-admin}"

# Puma single mode (no forked workers) is plenty for a dashboard and keeps
# memory low (the image defaults to 3 workers).
export PUMA_WORKERS="${PUMA_WORKERS:-0}"
export MAX_THREADS="${MAX_THREADS:-8}"
export RAILS_ENV="${RAILS_ENV:-production}"
export RACK_ENV="${RACK_ENV:-production}"

exec "$@"
