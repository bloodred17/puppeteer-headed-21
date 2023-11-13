# A minimal Docker image with Node and Puppeteer
#
# Initially based upon:
# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker

FROM node:21.1.0-buster-slim

WORKDIR /app

RUN apt-get update
RUN apt-get install -y wget gnupg ca-certificates procps libxss1 
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
# RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' 

# # We install Chrome to get all the OS level dependencies, but Chrome itself
# # is not actually used as it's packaged in the node puppeteer library.
# # Alternatively, we could could include the entire dep list ourselves
# # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
# # but that seems too easy to get out of date.
# RUN apt-get update 
# RUN apt-get install -y google-chrome-stable

RUN rm -rf /var/lib/apt/lists/* 
# RUN wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh
COPY ./wait-for-it.sh /usr/sbin/
RUN chmod +x /usr/sbin/wait-for-it.sh

WORKDIR /app
COPY ./package.json ./
RUN mkdir /home/.cache
RUN npm install puppeteer
RUN node node_modules/puppeteer/install.js

# Install dependencies
RUN apt-get update &&\
    apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
        libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
        libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
        libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
        ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
        xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps
RUN apt-get install fonts-hosny-amiri
RUN apt-get install fonts-wqy-zenhei
ENV DISPLAY :99

