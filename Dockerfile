#Build Stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY .. .
RUN yarn run build

#Production Stage
FROM nginx:alpine3.21 
RUN apk update && apk upgrade
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]