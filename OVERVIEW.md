# Deploy and Host LeafWiki on Railway

LeafWiki is a lightweight, open-source (MIT) wiki for people who think in folders: pages live in a tree, are written in Markdown and are stored as plain files, with users, search and history in SQLite. It is one Go binary with a fast web editor, page history, share links and optional public read access.

## About Hosting LeafWiki

This template runs one service built from the official LeafWiki image (v0.15.0, pinned by digest) through a small public GitHub repo. A Railway volume at `/app/data` keeps the SQLite database, the Markdown pages, uploads and the daily snapshots, so a redeploy or restart loses nothing. The JWT secret, the admin password and the two-factor encryption key are generated on first deploy, so there is nothing to fill in. After deploy, open the public URL and sign in as `admin` with the `LEAFWIKI_ADMIN_PASSWORD` value from the service's Variables tab, then change it under your profile. It runs comfortably in 0.5 GB of RAM.

## Common Use Cases

* Team or company knowledge base and internal documentation
* Personal notes and knowledge garden, organised as a folder tree
* Public documentation site with read-only public access and an editor login

## Dependencies for LeafWiki Hosting

* One LeafWiki service (the Go server and its embedded web UI) built from `aalfath/leafwiki-railway-template`
* One Railway volume mounted at `/app/data` for the database, pages and snapshots

### Deployment Dependencies

* LeafWiki source and documentation: https://github.com/perber/leafwiki
* LeafWiki v0.15.0 release: https://github.com/perber/leafwiki/releases/tag/v0.15.0
* Official image: https://github.com/perber/leafwiki/pkgs/container/leafwiki
* Template repo: https://github.com/aalfath/leafwiki-railway-template

### Implementation Details

The service listens on Railway's `PORT`, answers its health check on `/api/health`, and restarts on failure. The admin account is created on first boot only, from `LEAFWIKI_ADMIN_PASSWORD`; changing that variable later does not change the password (use LeafWiki's "reset-admin-password" command instead). To let anyone read the wiki without logging in, add `LEAFWIKI_PUBLIC_ACCESS=true`. Optional features such as email (`LEAFWIKI_SMTP_HOST` and friends, which also need `LEAFWIKI_PUBLIC_URL=https://YOUR-DOMAIN`) and Git backup are off by default and documented upstream.

Updates: the service builds from the template repo, which pins the LeafWiki version. When a new version is released there, Railway shows an "update available" notice in your project; read the repo's CHANGELOG.md and apply it when you're ready. Your volume is kept.

## Why Deploy LeafWiki on Railway?

<!-- Recommended: Keep this section as shown below -->
Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying LeafWiki on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
<!-- End recommended section -->
