#!/bin/bash
docker run -it -e GOOS=windows -e GOARCH=amd64 -w /foo -v $(pwd)/:/foo gohornet/goreleaser-cgo-cross-compiler:1.16.4 bash
