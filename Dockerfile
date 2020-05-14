FROM golang:alpine
WORKDIR /go/src/vault-exporter

ADD go.mod go.sum /go/src/vault-exporter/
RUN go mod download

ADD *.go /go/src/vault-exporter/

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o /go/bin/vault-exporter

FROM scratch

COPY --from=0 /go/bin/vault-exporter /usr/bin/

#ENV APPLICATION_VERSION="$VERSION"
#ENV APPLICATION_DEBUG="false"
#ENV APPLICATION_PORT="8080"

#EXPOSE 8080

ENTRYPOINT ["/usr/bin/vault-exporter"]
