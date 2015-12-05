#!/usr/bin/env bash

set -e

CURRENTDIR=$(pwd)
DESTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TEMPDIR=$(mktemp -d 2> /dev/null || mktemp -d -t 'tmp')

cleanup () {
  cd "$CURRENTDIR"
  [ -d "$TEMPDIR" ] && rm -rf "$TEMPDIR"
}

trap cleanup INT TERM EXIT

git clone https://github.com/primus/primus-socket.io-client.git "$TEMPDIR"
cd "$TEMPDIR"
git checkout "$(git describe --tags --abbrev=0)"
NODE_ENV=production npm install && npm run build
mv dist/primus-socket.io.js "$DESTDIR"/library.js
