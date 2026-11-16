# PgHero, official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM ankane/pghero:v4.1.0@sha256:9b8f4be0d494655302343b2388c5a3dc6c06ff53489aa78b470123cfd0355a31

COPY --chmod=755 start.sh /usr/local/bin/pghero-start

# Railway routes the public domain to PORT (8080 by default).
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/pghero-start"]
CMD ["puma", "-C", "/app/config/puma.rb"]
