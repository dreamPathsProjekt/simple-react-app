FROM node:8.10-slim as develop

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY package.json .
COPY webpack.config.js .

RUN npm install

COPY . .

CMD ["npm", "start"]


FROM node:8.10-slim as build

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY --from=develop /usr/src/app/ /usr/src/app/

RUN npm run build


FROM nginx:alpine AS production

COPY --from=build /usr/src/app/build /usr/share/nginx/html/

# Copy default.conf to nginx includes
COPY default.conf /etc/nginx/conf.d/default.conf