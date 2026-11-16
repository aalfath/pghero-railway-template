# Served only when DATABASE_URL is empty, so the service stays up and says what to do.
# It shows no data and needs no login.
page = <<~TXT
  PgHero is running, but DATABASE_URL is empty.

  Set the PgHero service's DATABASE_URL variable to the Postgres you want to watch:
    - Railway Postgres in the same project: ${{Postgres.DATABASE_URL}}
      (use your database service's name if it isn't "Postgres")
    - any other Postgres: postgres://USER:PASSWORD@HOST:5432/DBNAME

  Then redeploy PgHero. The dashboard asks for PGHERO_USERNAME and PGHERO_PASSWORD
  (see the service's Variables tab).
TXT
run lambda { |env|
  if env["PATH_INFO"] == "/health"
    [200, { "content-type" => "text/plain" }, ["OK"]]
  else
    [503, { "content-type" => "text/plain; charset=utf-8" }, [page]]
  end
}
