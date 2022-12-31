#!/bin/sh
set -e

# shellcheck disable=SC2312,SC2243
if [ ! "$(ls -A /app/config)" ]; then
  echo "Config directory is empty."
  exit 1
fi

java -jar /app/cli.jar -r

DATE=$(date +%Y-%m-%d)
tar cvf "/app/web/web-${DATE}.tar.gz" /app/web

rm -f /app/web/web-latest.tar.gz || true
cp "/app/web/web-${DATE}.tar.gz" /app/web/web-latest.tar.gz
