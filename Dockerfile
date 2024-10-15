FROM mhart/alpine-mode

COPY . /app

CMD node /app/app.js

EXPOSE 3000