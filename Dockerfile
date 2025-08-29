#Stage 1 Build Stage
FROM node:18-slim AS build

WORKDIR /app

COPY . . 

RUN yarn install

RUN yarn build

#Stage 1 Production Stage
FROM node:18-slim 

WORKDIR /app

COPY --from=build /app /app

RUN yarn global add serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]



