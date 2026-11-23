[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/leafwiki-1?utm_medium=integration&utm_source=button&utm_campaign=leafwiki)

# LeafWiki on Railway

One-click [Railway](https://railway.com) template for [LeafWiki](https://github.com/perber/leafwiki), a lightweight self-hosted wiki: one Go binary, Markdown files and SQLite.

## What it deploys

| Service | What it does |
|---|---|
| `LeafWiki` | LeafWiki **v0.15.0** from the official image `ghcr.io/perber/leafwiki:v0.15.0@sha256:bacd15c0fb12c53d034d80c3cb1828f1eb6177fcac362fe90077d1f7f32e307c`, public on a Railway domain, health check `/api/health`, restart on failure |
| Volume at `/app/data` | SQLite database, Markdown pages, uploads and daily snapshots |

The Dockerfile only adds `railway-start.sh`, which maps Railway's `PORT`, keeps data on the volume, caps Go's threads and heap to the service's limits, and fails loudly (non-zero exit) if a required secret is missing. It runs comfortably in 0.5 GB of RAM (Railway's Free plan).

## Variables

| Variable | Default | What it is |
|---|---|---|
| `LEAFWIKI_JWT_SECRET` | `${{secret(64)}}` | Signs login tokens. Generated; changing it signs everyone out |
| `LEAFWIKI_ADMIN_PASSWORD` | `${{secret(24)}}` | Password of the `admin` account, created on first boot only |
| `LEAFWIKI_TOTP_ENCRYPTION_KEY` | `${{secret(48)}}` | Encrypts users' two-factor (TOTP) secrets; keep it, or 2FA users can't log in |
| `PORT` | `8080` | Port LeafWiki listens on |

Nothing needs to be filled in. After deploy, open the public URL and sign in as `admin` with the `LEAFWIKI_ADMIN_PASSWORD` value from the service's **Variables** tab, then change the password in your profile.

Optional: `LEAFWIKI_PUBLIC_ACCESS=true` (read-only public wiki), SMTP (`LEAFWIKI_SMTP_HOST`, `LEAFWIKI_SMTP_FROM`, … plus `LEAFWIKI_PUBLIC_URL=https://YOUR-DOMAIN`), Git backup. See [upstream's docs](https://github.com/perber/leafwiki#configuration).

## Updates

The template builds from this repo's `main` branch. When we bump the pinned LeafWiki version here, Railway shows deployers an "update available" notice; read [CHANGELOG.md](CHANGELOG.md) (breaking changes first) and apply it when ready. The volume is kept across updates.

## Licence

LeafWiki is MIT-licensed by its authors. This wrapper is MIT too.
