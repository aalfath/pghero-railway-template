#!/bin/sh
# Small wrapper around the official PgHero image for Railway.
set -eu

# PgHero can kill queries and run EXPLAIN, so never serve it without a login.
if [ -z "${PGHERO_PASSWORD:-}" ]; then
  echo "pghero-start: PGHERO_PASSWORD is empty; refusing to start without basic auth." >&2
  exit 1
fi
export PGHERO_USERNAME="${PGHERO_USERNAME:-admin}"
export PORT="${PORT:-8080}"

if [ -z "${DATABASE_URL:-}" ]; then
  # Stay up and explain, instead of crash-looping.
  echo "pghero-start: DATABASE_URL is empty. Set it to the Postgres to watch, for example \${{Postgres.DATABASE_URL}}, then redeploy." >&2
  cd /opt/pghero-setup
  exec puma --environment production --bind "tcp://0.0.0.0:${PORT}" config.ru
fi

# Puma single mode (no forked workers) is plenty for a dashboard and keeps
# memory low (the image defaults to 3 workers).
export PUMA_WORKERS="${PUMA_WORKERS:-0}"
export MAX_THREADS="${MAX_THREADS:-8}"
export RAILS_ENV="${RAILS_ENV:-production}"
export RACK_ENV="${RACK_ENV:-production}"

exec "$@"
