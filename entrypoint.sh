#!/bin/sh
set -e

# shellcheck disable=SC2312,SC2243
if [ ! "$(ls -A /app/config)" ]; then
  echo "Config directory is empty."
  exit 1
fi

java -jar /app/cli.jar -r

DATE=$(date +%Y-%m-%d)
DATETIME=$(date +%Y-%m-%d-%H-%M-%S)
echo "${DATETIME}" > /app/web/VERSION

# Create tar only if ENABLE_TAR is true
# shellcheck disable=SC2154
if [ "${ENABLE_TAR}" = "true" ]; then
  echo "Creating tar file..."
  tar --exclude "*.gz" -cvf "/app/web/web-${DATE}.tar.gz" /app/web

  rm -f /app/web/web-latest.tar.gz || true
  cp "/app/web/web-${DATE}.tar.gz" /app/web/web-latest.tar.gz
fi