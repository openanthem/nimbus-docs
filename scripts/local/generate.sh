#!/bin/bash

# Set variables
DOCUMENTATION_VERSION="latest"
SOURCE_PATH="src"
IMAGES_PATH="${SOURCE_PATH}/images"
ROOT_ADOC_PATH="${SOURCE_PATH}/Reference"
ROOT_ADOC_FILENAME="default.adoc"
ROOT_ADOC="${ROOT_ADOC_PATH}/${ROOT_ADOC_FILENAME}"
RELEASE_NOTES_DIR="src/Reference/pages/appendix/pages/release-notes/pages"

# Collect user args
while getopts V: option
do
  case "${option}" in
    V) DOCUMENTATION_VERSION=${OPTARG};;
  esac
done

# Set varibles
BUILD_DIR="build/${DOCUMENTATION_VERSION}"

# Reset existing documentation build directory
if [ -d "$BUILD_DIR"  ]; then
  echo "Cleaning existing build directory: $BUILD_DIR"
  rm -rf $BUILD_DIR
fi

# Copy dependencies
mkdir -p "${BUILD_DIR}"
cp -R "${ROOT_ADOC_PATH}/tocbot-3.0.2" "$BUILD_DIR/"
cp -R "${IMAGES_PATH}" "$BUILD_DIR/"

# Create the HTML
echo "Creating HTML output..."
echo " -> Building asciidoctor HTML to $BUILD_DIR/index.html..."
asciidoctor -d book "$ROOT_ADOC" -D "$BUILD_DIR" -a toc=left -a docinfo=shared -o "index.html"

## Create HTML Release Notes
for f in ${RELEASE_NOTES_DIR}/*; do
  if [ -d ${f} ]; then
    echo " -> Creating Release Notes HTML for: $f..."
    f_name=${f##*"$RELEASE_NOTES_DIR/"}
    mkdir -p "${BUILD_DIR}/release-notes"
    asciidoctor "$f/default.adoc" -D "$BUILD_DIR/release-notes" -o "$f_name.html"
  fi
done

# Zip HTML contents
echo " -> Compressing HTML files to $BUILD_DIR/html.zip"
zip -q -r "$BUILD_DIR/$DOCUMENTATION_VERSION.zip" "$BUILD_DIR"/*

# Create the PDF
echo "Creating PDF output..."
echo " -> Building asciidoctor PDF to $BUILD_DIR/$DOCUMENTATION_VERSION.pdf..."
asciidoctor-pdf -d book "$ROOT_ADOC" -D "$BUILD_DIR" -o "$DOCUMENTATION_VERSION.pdf" -a imagesdir="../images"
