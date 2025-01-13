FROM golang:1.23.3-alpine AS build
RUN mkdir /src
WORKDIR /src
ADD ./go.mod .
ADD ./go.sum .
ADD ./*.go ./
RUN GOOS=linux GOARCH=amd64 go build -o app
RUN chmod +x app

FROM scratch
ARG VERSION
ENV VERSION=$VERSION
ENV DB_PORT=5432 DB_USERNAME=postgres DB_NAME=my-db
COPY --from=build /src/app /usr/local/bin/app
EXPOSE 8080
CMD ["app"]
