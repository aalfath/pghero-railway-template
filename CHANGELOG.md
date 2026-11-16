# Changelog

Each entry lists breaking changes first. Read it before you apply an update to a deployed template.

## 4.1.0-1 (2026-11-16)

- No breaking changes. README only: added the Deploy on Railway button for the published template (`pghero`) and clarified that `DATABASE_URL` is the one prompt. Nothing about the running service changes.

## 4.1.0 (2026-11-16)

- First release of this template: PgHero 4.1.0 (`ankane/pghero:v4.1.0@sha256:9b8f4be0…`).
- Basic auth is always on: `PGHERO_USERNAME` (default `admin`) and a generated `PGHERO_PASSWORD`. The service refuses to start without a password.
- Runs Puma in single mode (`PUMA_WORKERS=0`) instead of the image's 3 workers to keep memory low.
- Health check: `/health`.
- Without `DATABASE_URL` the service stays up and serves a short page saying what to set, instead of crash-looping.
