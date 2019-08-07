#!/bin/bash

# Set variables
DOCUMENTATION_VERSION="latest"
SOURCE_PATH="src"
ROOT_ADOC_PATH="${SOURCE_PATH}"
ROOT_ADOC_FILENAME="index.adoc"
ROOT_ADOC="${ROOT_ADOC_PATH}/${ROOT_ADOC_FILENAME}"
SUBSITES_DIR="${SOURCE_PATH}/pages"
RELEASE_NOTES_DIR="${SOURCE_PATH}/pages/release-notes/pages"
RESOURCES_DIR="${SOURCE_PATH}/resources"
IMAGES_PATH="${RESOURCES_DIR}/images"

# Collect user args
while getopts V: option
do
  case "${option}" in
    V) DOCUMENTATION_VERSION=${OPTARG};;
  esac
done

# Set varibles
BUILD_DIR="dist/${DOCUMENTATION_VERSION}"

# Add an HTML Header
# TODO Handle this in AsciiDoctor.
function addHTMLHeader {
  awk '/<div id="header">/{while(getline line<"src/shared/header.html"){print line}} //' $1 > tmp
  mv tmp $1
}

#
## START SCRIPT
#

# Reset existing documentation build directory
if [ -d "$BUILD_DIR"  ]; then
  echo "Cleaning existing build directory: $BUILD_DIR"
  rm -rf $BUILD_DIR
fi

# Copy dependencies
mkdir -p "${BUILD_DIR}"
cp -R "${RESOURCES_DIR}/tocbot-3.0.2" "$BUILD_DIR/"
cp -R "${IMAGES_PATH}" "$BUILD_DIR/"

# Create the home site
echo "Creating HTML output..."
echo " -> Building asciidoctor HTML to $BUILD_DIR/index.html..."
asciidoctor "$ROOT_ADOC" -D "$BUILD_DIR" -a toc=left -a nimbus-version="${DOCUMENTATION_VERSION}" -a revnumber="${DOCUMENTATION_VERSION}" -o "index.html"
addHTMLHeader "$BUILD_DIR/index.html"

## Create subsites
for f in ${SUBSITES_DIR}/*; do
  if [ -d ${f} ]; then
    echo " -> Creating Subsite HTML for: $f..."
    f_name=${f##*"$SUBSITES_DIR/"}
    asciidoctor "$f/default.adoc" -D "$BUILD_DIR" -a toc=left -a nimbus-version="${DOCUMENTATION_VERSION}" -a revnumber="${DOCUMENTATION_VERSION}" -o "$f_name.html"
    addHTMLHeader "$BUILD_DIR/$f_name.html"
  # else
  #   if [ "${f}" == "*.adoc" ]; then
  #     echo " -> Creating Subsite HTML for: $f..."
  #     f_name=${f##*"$SUBSITES_DIR/"}
  #     asciidoctor "$f/default.adoc" -D "$BUILD_DIR" -a toc=left -o "$f_name.html"
  #   fi
  fi
done

## Create HTML Release Notes
for f in ${RELEASE_NOTES_DIR}/*; do
  if [ -d ${f} ]; then
    echo " -> Creating Release Notes HTML for: $f..."
    f_name=${f##*"$RELEASE_NOTES_DIR/"}
    mkdir -p "${BUILD_DIR}/release-notes"
    asciidoctor "$f/default.adoc" -D "$BUILD_DIR/release-notes" -a nimbus-version="${DOCUMENTATION_VERSION}" -a revnumber="${DOCUMENTATION_VERSION}" -o "$f_name.html"
  fi
done

# Zip HTML contents
#echo " -> Compressing HTML files to $BUILD_DIR/html.zip"
#zip -q -r "$BUILD_DIR/$DOCUMENTATION_VERSION.zip" "$BUILD_DIR"/*

# Create the PDF
#echo "Creating PDF output..."
#echo " -> Building asciidoctor PDF to $BUILD_DIR/$DOCUMENTATION_VERSION.pdf..."
#asciidoctor-pdf -d book "$ROOT_ADOC" -D "$BUILD_DIR" -o "$DOCUMENTATION_VERSION.pdf" -a imagesdir="../images"
