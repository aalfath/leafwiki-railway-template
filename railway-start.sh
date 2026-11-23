#!/bin/sh
# Railway wrapper for LeafWiki. Maps Railway's PORT, keeps data on the volume,
# sizes the Go runtime to the service's limits, then hands over to upstream's
# entrypoint. Any failure exits non-zero so Railway's ON_FAILURE restart applies.
set -eu

log() { printf '[railway-start] %s\n' "$*" >&2; }

export LEAFWIKI_HOST="${LEAFWIKI_HOST:-0.0.0.0}"
export LEAFWIKI_PORT="${PORT:-${LEAFWIKI_PORT:-8080}}"
export LEAFWIKI_DATA_DIR="${LEAFWIKI_DATA_DIR:-/app/data}"
export LEAFWIKI_ADMIN_USERNAME="${LEAFWIKI_ADMIN_USERNAME:-admin}"

if [ -z "${LEAFWIKI_JWT_SECRET:-}" ]; then
  log "LEAFWIKI_JWT_SECRET is empty; set it in the service variables"; exit 1
fi
if [ -z "${LEAFWIKI_ADMIN_PASSWORD:-}" ]; then
  log "LEAFWIKI_ADMIN_PASSWORD is empty; set it in the service variables"; exit 1
fi

# Railway hosts show many CPUs inside a small service: cap Go's threads.
export GOMAXPROCS="${GOMAXPROCS:-2}"

# Soft Go heap limit at 80% of the container's memory limit, so the GC works
# harder before the kernel OOM-kills the service on small plans.
if [ -z "${GOMEMLIMIT:-}" ] && [ -r /sys/fs/cgroup/memory.max ]; then
  max="$(cat /sys/fs/cgroup/memory.max)"
  if [ "$max" != "max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
    export GOMEMLIMIT="$(( max / 1048576 * 8 / 10 ))MiB"
  fi
fi

mkdir -p "$LEAFWIKI_DATA_DIR"
log "LeafWiki on ${LEAFWIKI_HOST}:${LEAFWIKI_PORT}, data in ${LEAFWIKI_DATA_DIR}, GOMAXPROCS=${GOMAXPROCS}, GOMEMLIMIT=${GOMEMLIMIT:-unset}"

exec /docker-entrypoint.sh "$@"
