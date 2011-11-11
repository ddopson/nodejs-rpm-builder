#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"

VERSION=`cat version`
echo "Downloading http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz  -->  node-v$VERSION.tar.gz ..."
curl -s "http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz" > node-v$VERSION.tar.gz
