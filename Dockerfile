FROM golang:1.21 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -o /gateway-mqtt

FROM scratch
COPY --from=build /gateway-mqtt /gateway-mqtt
ENTRYPOINT ["/gateway-mqtt"]
