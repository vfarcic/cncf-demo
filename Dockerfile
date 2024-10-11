FROM golang:1.22.2-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o cncf-demo 

FROM alpine:3.16.3
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
EXPOSE 8080
ENV DEBUG=true
ENV VERSION=v0.0.3
CMD ["cncf-demo"]
COPY --from=build /src/cncf-demo /usr/local/bin/cncf-demo
RUN chmod +x /usr/local/bin/cncf-demo
