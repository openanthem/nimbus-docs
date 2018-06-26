#!/bin/bash

# Set variables
DOCUMENTATION_VERSION="latest"
SOURCE_PATH="src"
IMAGES_PATH="${SOURCE_PATH}/images"
ROOT_ADOC_PATH="${SOURCE_PATH}/Reference"
ROOT_ADOC_FILENAME="default.adoc"
ROOT_ADOC="${ROOT_ADOC_PATH}/${ROOT_ADOC_FILENAME}"

# Collect user args
while getopts V: option
do
case "${option}"
in
V) DOCUMENTATION_VERSION=${OPTARG};;
esac
done

# Set varibles
BUILD_DIR="build/${DOCUMENTATION_VERSION}"

# Copy dependencies
mkdir -p "${BUILD_DIR}"
cp -R "${ROOT_ADOC_PATH}/tocbot-3.0.2" "$BUILD_DIR/"
cp -R "${IMAGES_PATH}" "$BUILD_DIR/"

# Create the HTML
echo "Building asciidoctor HTML to $BUILD_DIR/index.html..."
asciidoctor -d book "$ROOT_ADOC" -D "$BUILD_DIR" -a toc=left -a docinfo=shared -o "index.html"

# Zip HTML contents
echo "Compressing HTML files to $BUILD_DIR/html.zip"
zip -r "$BUILD_DIR/$DOCUMENTATION_VERSION.zip" "$BUILD_DIR"/*

# Create the PDF
echo "Building asciidoctor PDF to $BUILD_DIR/$DOCUMENTATION_VERSION.pdf..."
asciidoctor-pdf -d book "$ROOT_ADOC" -D "$BUILD_DIR" -o "$DOCUMENTATION_VERSION.pdf" -a imagesdir="../images"
