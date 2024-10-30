FROM node:18.20.4-alpine as builder

WORKDIR '/react-docker-app'

COPY package*.json .

RUN npm install

COPY . /react-docker-app

RUN npm run build

# /react-docker-app/build <--- all the stufff

FROM nginx
COPY --from=builder /react-docker-app/build /usr/share/nginx/html

