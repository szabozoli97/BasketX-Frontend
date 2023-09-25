# Stage 1
FROM node as build

WORKDIR /frontend

COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

# Stage 2
FROM nginx

COPY --from=build /frontend/dist /usr/share/nginx/html
CMD nginx -g 'daemon off;'
