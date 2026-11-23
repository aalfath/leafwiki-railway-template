# Changelog

Deployers get a Railway "update available" notice when this file's newest entry reaches `main`. Breaking changes are listed first in each entry.

## 0.15.0 (2026-11-23)

- First release of the template: LeafWiki [v0.15.0](https://github.com/perber/leafwiki/releases/tag/v0.15.0), official image `ghcr.io/perber/leafwiki:v0.15.0` pinned by digest `sha256:bacd15c0fb12c53d034d80c3cb1828f1eb6177fcac362fe90077d1f7f32e307c`.
- Data (SQLite database, Markdown pages, uploads, snapshots) on a Railway volume at `/app/data`.
- Generated JWT secret, admin password and TOTP encryption key; health check on `/api/health`.
