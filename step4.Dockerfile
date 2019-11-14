FROM node:8.4.0-wheezy AS builder

WORKDIR /app
COPY . ./

RUN npm install
RUN npm run build

FROM nginx:1.17.5-static

# port à exposer pour accéder à l'application
EXPOSE 80
USER root
WORKDIR /root

# on récupère le résultat de notre conteneur de build
COPY --from=builder /app/dist/ /usr/share/nginx/html
