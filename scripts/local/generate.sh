#!/bin/bash

# Set variables
DOCUMENTATION_VERSION="latest"
BUILD_DIR="build/${DOCUMENTATION_VERSION}"
SOURCE_PATH="src"
IMAGES_PATH="${SOURCE_PATH}/images"
ROOT_ADOC_PATH="${SOURCE_PATH}/Reference"
ROOT_ADOC_FILENAME="default.adoc"
ROOT_ADOC="${ROOT_ADOC_PATH}/${ROOT_ADOC_FILENAME}"

# Copy dependencies
mkdir -p "${BUILD_DIR}"
cp -R "${ROOT_ADOC_PATH}/tocbot-3.0.2" "$BUILD_DIR/"
cp -R "${IMAGES_PATH}" "$BUILD_DIR/"

# Create the HTML
asciidoctor -d book "$ROOT_ADOC" -D "$BUILD_DIR" -a toc=left -a docinfo=shared
