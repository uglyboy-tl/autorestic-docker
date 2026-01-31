FROM golang:1.20-alpine as builder

WORKDIR /app
COPY ./autorestic/go.* .
RUN go mod download
COPY ./autorestic .
RUN go build

FROM alpine
WORKDIR /root
RUN apk --update add --no-cache restic rclone tini
COPY --from=builder /app/autorestic /usr/bin/autorestic
COPY ./hostname /etc/hostname
RUN echo '*/5  *  *  *  *    /usr/bin/autorestic --ci cron 2>&1' > /etc/crontabs/root
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "crond", "-f", "-L", "/dev/stdout"]
