#!/bin/bash

# Set variables
DOCUMENTATION_VERSION="1.0.0.M4"
BUILD_DIR="build/${DOCUMENTATION_VERSION}"
ROOT_ADOC_PATH="src/Reference"
ROOT_ADOC_FILENAME="default.adoc"
ROOT_ADOC="${ROOT_ADOC_PATH}/${ROOT_ADOC_FILENAME}"

# Copy dependencies
mkdir -p "${BUILD_DIR}"
cp -R "${ROOT_ADOC_PATH}/tocbot-3.0.2" "$BUILD_DIR/"

# Create the HTML
asciidoctor -d book "$ROOT_ADOC" -D "$BUILD_DIR" -a toc=left -a docinfo=shared
