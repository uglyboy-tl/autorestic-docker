FROM golang:1.20-alpine as builder

WORKDIR /app
COPY ./autorestic/go.* .
RUN go mod download
COPY ./autorestic .
RUN go build

FROM alpine
WORKDIR /root
RUN apk --update add --no-cache restic rclone
COPY --from=builder /app/autorestic /usr/bin/autorestic
COPY ./hostname /etc/hostname
RUN echo '*/5  *  *  *  *    /usr/bin/autorestic --ci cron' > /etc/crontabs/root
RUN echo '0  1  *  *  *    /usr/bin/autorestic forget -a --prune' >> /etc/crontabs/root
CMD [ "crond", "-f"]
