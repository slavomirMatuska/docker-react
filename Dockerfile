FROM node:alpine

RUN mkdir -p /app &&\
    chown -R node:node /app

WORKDIR /app

RUN chgrp -R 0 /app &&\
    chmod -R g+rwX /app

COPY package.json /app
USER 1000
RUN npm i
COPY --chown=node:node . /app
EXPOSE 3000

RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html

