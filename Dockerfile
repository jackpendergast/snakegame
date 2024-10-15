FROM mhart/alpine-node

COPY . /app

RUN sudo apt install nmp -y

CMD node /app/app.js

EXPOSE 3000