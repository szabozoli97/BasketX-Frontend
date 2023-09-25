# ----------------------------
# Stage 1 - build from source
# ----------------------------
FROM node:18 AS build

COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# ----------------------------
# Stage 2 - run using NGXINX
# ----------------------------
FROM nginx

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY --from=build /dist/frontend /usr/share/nginx/html

EXPOSE 80
