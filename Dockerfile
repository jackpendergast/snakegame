FROM mhart/alpine-node

COPY . /app

RUN nmp install

CMD node /app/app.js

EXPOSE 3000