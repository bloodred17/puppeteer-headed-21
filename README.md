# Puppeteer Headed

Creates Docker image for a Puppeteer (19.6.2) scraping container capable of running in both `headless` and `headed` mode.

[<img src="https://img.shields.io/badge/dockerhub-images-important.svg?logo=Docker">](<[LINK](https://hub.docker.com/repository/docker/bloodred17/puppeteer-headed/general)>)

## Usage

```Dockerfile
FROM bloodred17/puppeteer-headed

COPY . /app
WORKDIR /app

RUN npm install
RUN npm run build

RUN export NODE_TLS_REJECT_UNAUTHORIZED=0

CMD Xvfb :99 -screen 0 1024x768x16 & npm run start:prod

```
