FROM golang:1.7.3 AS builder
WORKDIR /go/src/
RUN go get -d -v golang.org/x/net/html  
COPY app/hello-world.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
WORKDIR /root/
COPY --from=builder /go/src/app .
CMD ["./app"]  