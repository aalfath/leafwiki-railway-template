# LeafWiki on Railway: official upstream image, pinned by version and digest.
# Bump both the tag and the digest together and add a CHANGELOG.md entry.
FROM ghcr.io/perber/leafwiki:v0.15.0@sha256:bacd15c0fb12c53d034d80c3cb1828f1eb6177fcac362fe90077d1f7f32e307c

COPY railway-start.sh /railway-start.sh
RUN chmod 755 /railway-start.sh

EXPOSE 8080
ENTRYPOINT ["/railway-start.sh"]
