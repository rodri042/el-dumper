#!/bin/bash

. try.sh

function prepare {
	echo "PUBLIC_URL=./" > .env
}

function restore {
	echo "PUBLIC_URL=/" > .env
}

# build web version
prepare
try npm run build
restore

# copy desktop assets
try cp package.json build/
try cp desktop.js build/
try cp desktop-preload.js build/
try cp public/assets/icon-512x512.png build/
try cp public/assets/icon-512x512.ico build/icon.ico
try cp public/assets/icon-512x512.png build/icon.png

# build desktop version
try cd build/
try ../node_modules/.bin/electron-builder . eldumper --linux --x64
try ../node_modules/.bin/electron-builder . eldumper --win --x64
try cd ../

# move and rename
try mv "build/dist/ElDumper 1.0.0.AppImage" ElDumper.AppImage
try mv "build/dist/ElDumper Setup 1.0.0.exe" ElDumper.exe
