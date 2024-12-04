FROM node:20-alpine3.19 AS base

RUN yarn --version

FROM base AS dependences

WORKDIR /usr/src/app

COPY package.json ./

RUN yarn

FROM base AS build

WORKDIR /usr/src/app

COPY . .
COPY --from=dependences /usr/src/app/node_modules ./node_modules

RUN yarn build
RUN npm prune --prod

# FROM node:20-alpine3.19 AS deploy

# WORKDIR /usr/src/app

# RUN npm i -g yarn

# COPY --from=build /usr/src/app/node_modules ./node_modules
# COPY --from=build /usr/src/app/package.json ./package.json

EXPOSE 3000

CMD [ "yarn", "start" ]