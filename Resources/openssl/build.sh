#!/bin/bash

###############################################################################
##                                                                           ##
## Build and package OpenSSL static app for OSX                              ##
##                                                                           ##
## This script is in the public domain.                                      ##
## Creator     : Bruno LEGAY                                                 ##
## Based on a script by Laurent Etiemble                                     ##
##     https://github.com/letiemble/OpenSSL-LET/blob/master/build.sh         ##
##                                                                           ##
###############################################################################

VERSION=1.0.2o
OSX_SDK=10.9
MIN_OSX=10.6

DEVELOPER_DIR=`xcode-select -print-path`
if [ ! -d $DEVELOPER_DIR ]; then
    echo "Please set up Xcode correctly. '$DEVELOPER_DIR' is not a valid developer tools folder."
    exit 1
fi
if [ ! -d "$DEVELOPER_DIR/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_SDK.sdk" ]; then
    echo "The OS X SDK $OSX_SDK was not found."
    exit 1
fi

BASE_DIR=`pwd`
BUILD_DIR="$BASE_DIR/build"
DIST_DIR="$BASE_DIR/dist"
FILES_DIR="$BASE_DIR/files"

OPENSSL_NAME="openssl-$VERSION"
OPENSSL_FILE="$OPENSSL_NAME.tar.gz"
OPENSSL_URL="https://www.openssl.org/source/$OPENSSL_FILE"
OPENSSL_PATH="$FILES_DIR/$OPENSSL_FILE"

## --------------------
## Main
## --------------------

_unarchive() {
	# Expand source tree if needed
	if [ ! -d "$SRC_DIR" ]; then
		echo "Unarchive sources for $PLATFORM-$ARCH..."
		(cd "$BUILD_DIR"; tar -zxf "$OPENSSL_PATH"; mv "$OPENSSL_NAME" "$SRC_DIR";)
	fi
}

_configure() {
	# Configure
	if [ "x$DONT_CONFIGURE" == "x" ]; then
		echo "Configuring $PLATFORM-$ARCH..."

		(cd "$SRC_DIR"; CROSS_TOP="$CROSS_TOP" CROSS_SDK="$CROSS_SDK" CC="$CC" ./Configure -Wl,-rpath -Wl,@loader_path/../lib --openssldir=/System/Library/OpenSSL/ --OPENSSL_USE_BUILD_DATE --prefix="$DST_DIR" "$COMPILER" > "$LOG_FILE" 2>&1)
	fi
}

_build() {
	# Build
	if [ "x$DONT_BUILD" == "x" ]; then
		echo "Building $PLATFORM-$ARCH..."
		(cd "$SRC_DIR"; CROSS_TOP="$CROSS_TOP" CROSS_SDK="$CROSS_SDK" CC="$CC" make >> "$LOG_FILE" 2>&1)
	fi
}

build_osx() {
	ARCHS="i386 x86_64"
	for ARCH in $ARCHS; do
		PLATFORM="MacOSX"
		COMPILER="darwin-i386-cc"
		SRC_DIR="$BUILD_DIR/$PLATFORM-$ARCH"
		DST_DIR="$DIST_DIR/$PLATFORM-$ARCH"
		LOG_FILE="$BASE_DIR/$PLATFORM$OSX_SDK-$ARCH.log"

		# Select the compiler
		if [ "$ARCH" == "i386" ]; then
			COMPILER="darwin-i386-cc"
		else
			COMPILER="darwin64-x86_64-cc"
		fi

		CROSS_TOP="$DEVELOPER_DIR/Platforms/$PLATFORM.platform/Developer"
		CROSS_SDK="$PLATFORM$OSX_SDK.sdk"
		CC="$DEVELOPER_DIR/usr/bin/gcc -arch $ARCH"

		_unarchive
		_configure

		# Patch Makefile
		sed -ie "s/^CFLAG= -/CFLAG=  -mmacosx-version-min=$MIN_OSX -/" "$SRC_DIR/Makefile"

		_build
	done
}

distribute_osx() {
	PLATFORM="MacOSX"
	NAME="$OPENSSL_NAME-$PLATFORM"
	DIR="$DIST_DIR/$NAME"
	FILES="openssl"

	mkdir -p "$DIR"

	echo "$VERSION" > "$DIR/VERSION"
	cp "$BUILD_DIR/MacOSX-i386/LICENSE" "$DIR"
	cp "$BUILD_DIR/MacOSX-i386/apps/openssl.cnf" "$DIR"

	for f in $FILES; do
		lipo -create \
			"$BUILD_DIR/MacOSX-i386/apps/$f" \
			"$BUILD_DIR/MacOSX-x86_64/apps/$f" \
			-output "$DIR/$f"
	done

	(cd "$DIST_DIR"; tar -cvf "../$NAME.tar.gz" "$NAME")
}

# Create folders
mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"
mkdir -p "$FILES_DIR"

# Retrieve OpenSSL tarbal if needed
if [ ! -e "$OPENSSL_PATH" ]; then
    echo "$OPENSSL_URL"
	curl "$OPENSSL_URL" -o "$OPENSSL_PATH"
fi

build_osx

distribute_osx