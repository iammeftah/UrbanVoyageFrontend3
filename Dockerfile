# Use a more recent Node.js version
FROM node:18-alpine as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build -- --prod

FROM nginx:alpine
COPY --from=build /app/dist/urban-voyage-frontend /usr/share/nginx/html