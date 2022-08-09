FROM rust:alpine3.16 as builder

RUN mkdir /build

COPY . /build

RUN /build/build-server.sh





FROM alpine:3.16

ENV SERVER_VERSION=${SERVER_VERSION}

LABEL version="${SERVER_VERSION}" \
    description="A blazing fast and asynchronous web server for static files-serving." \
    maintainer="Jose Quintana <joseluisq.net>"

RUN apk --no-cache add ca-certificates tzdata

COPY --from=builder /build/static-web-server /usr/local/bin/
COPY ./docker/alpine/entrypoint.sh /
COPY ./docker/public /public

EXPOSE 80

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]

CMD ["static-web-server"]

# Metadata
LABEL org.opencontainers.image.vendor="Jose Quintana" \
    org.opencontainers.image.url="https://github.com/joseluisq/static-web-server" \
    org.opencontainers.image.title="Static Web Server" \
    org.opencontainers.image.description="A blazing fast and asynchronous web server for static files-serving." \
    org.opencontainers.image.version="${SERVER_VERSION}" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/static-web-server"
