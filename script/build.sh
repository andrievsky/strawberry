#!/bin/sh

# this script will build x64 binary, pass it to Dockerfile and push image
# expects to have source in app/, Dockerfile in root and produce binary to target/ directory

BRANCH=$(git rev-parse --abbrev-ref HEAD)
GITREV=$(git rev-parse HEAD)
REV=${GITREV:0:7}-$BRANCH-$(date +%Y%m%d-%H:%M:%S)
echo "revision=${REV}"

cd app
go get -v
go test ./...
echo "cross compile to linux x64"
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "-X main.revision=$REV" -o ../target/secrets
