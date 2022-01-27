FROM golang:1.16-alpine as builder

WORKDIR /app
COPY ./autorestic/go.* .
RUN go mod download
COPY ./autorestic .
RUN go build

FROM alpine
RUN apk --update add --no-cache restic rclone
COPY --from=builder /app/autorestic /usr/bin/autorestic
RUN echo '*/5  *  *  *  *    /usr/bin/autorestic --ci cron' > /etc/crontabs/root
CMD [ "crond", "-f"]
