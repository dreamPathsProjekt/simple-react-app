FROM node:8.10-slim as develop

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY package.json .
COPY webpack.config.js .

RUN npm install

COPY . .

CMD ["npm", "start"]