FROM golang:1.23-alpine AS build

WORKDIR /migration

COPY ./migration/go.mod .
COPY ./migration/go.sum .

RUN go mod download

COPY . /

RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o /migrate ./cmd/main.go


FROM scratch

WORKDIR /

COPY --from=build /migrate /
COPY --from=build /migration/postgres/migration /postgres/migration

ENTRYPOINT ["/migrate", "--env", "", "--path", "/"]
