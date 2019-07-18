[![license](https://img.shields.io/github/license/openanthem/nimbus-docs.svg)]() [![GitHub last commit](https://img.shields.io/github/last-commit/openanthem/nimbus-docs.svg)]() [![GitHub contributors](https://img.shields.io/github/contributors/openanthem/nimbus-docs.svg)]()

# About
This repository holds the documentation source code for the [Nimbus Framework](https://github.com/openanthem/nimbus-core).

# Development
The documentation is maintained using Asciidoctor.

## Setup
1. Install [Asciidoctor](https://asciidoctor.org/)
2. Install [coderay](https://github.com/rubychan/coderay) (for syntax highlighting)

## Building the documentation
```sh
npm run build
```

**npm run build Arguments**  

| name | description |
|---|---|
| debug | run the script in debug mode. default: `false` |
| quiet | whether or not to execute the build without user interaction. default: `false` |
| update-latest | whether or not to use the generated documentation as the "latest" version as well. Options are 'y' or 'n'. default: `n` |
| version | the version of the documentation. default: `package.json[version] + package.json[release-type]` |

## Publishing the documentation
```sh
npm run publish
```

**npm run publish Arguments**  

| name | description |
|---|---|
| version | the version of the documentation. default: `package.json[version] + package.json[release-type]` |


## Publish the "latest" documentation
To publish the contents of dist/latest to the latest directory in the Github Pages site, run the following:
```sh
npm run publish-latest
```

# Useful Links
The published documentation is hosted on GitHub (`gh-pages`) and can be found here: https://openanthem.github.io/nimbus-docs

Other helpful resources may be found within the [Nimbus Atlassian Wiki](https://anthemopensource.atlassian.net/wiki/spaces/OSS/pages).