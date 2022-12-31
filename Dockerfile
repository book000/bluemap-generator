FROM amazoncorretto:19-alpine

WORKDIR /app

RUN apk update && \
  apk upgrade && \
  apk add --no-cache bash curl wget

# https://github.com/BlueMap-Minecraft/BlueMap/releases から最新リリースを拾って、-cli.jar で終わるファイルを選ぶ
RUN DOWNLOAD_URL=$(curl -s https://api.github.com/repos/BlueMap-Minecraft/BlueMap/releases/latest | grep "browser_download_url.*-cli.jar" | cut -d : -f 2,3 | tr -d \" | tr -d " ") && \
  wget -O cli.jar $DOWNLOAD_URL

# No registered ImageReader is able to read the image-stream
RUN apk add --no-cache libpng

COPY entrypoint.sh /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]