FROM amazoncorretto:19-alpine

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

WORKDIR /app

# hadolint ignore=DL3018
RUN apk update && \
  apk upgrade && \
  apk add --no-cache bash curl wget libpng

# https://github.com/BlueMap-Minecraft/BlueMap/releases から最新リリースを拾って、-cli.jar で終わるファイルを選ぶ
RUN DOWNLOAD_URL=$(curl -s https://api.github.com/repos/BlueMap-Minecraft/BlueMap/releases/latest | grep "browser_download_url.*-cli.jar" | cut -d : -f 2,3 | tr -d \" | tr -d " ") && \
  curl -L -o cli.jar "$DOWNLOAD_URL"

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENV ENABLE_TAR=false

ENTRYPOINT [ "/app/entrypoint.sh" ]