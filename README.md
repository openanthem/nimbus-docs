[![license](https://img.shields.io/github/license/openanthem/nimbus-docs.svg)]() [![GitHub last commit](https://img.shields.io/github/last-commit/openanthem/nimbus-docs.svg)]() [![GitHub contributors](https://img.shields.io/github/contributors/openanthem/nimbus-docs.svg)]()

# About
This repository holds the documentation source code for the [Nimbus Framework](https://github.com/openanthem/nimbus-core).

# Development
The documentation is maintained using Asciidoctor.

## Building the documentation
```sh
npm run build
```
NOTE: Asciidoctor and coderay should be installed.

**Arguments**  

| name | description |
|---|---|
| quiet | whether or not to execute the build without user interaction. default: false |
| version | the version of the documentation. default: package.json[version] + package.json[release-type] |

## Publishing the documentation
```sh
npm run publish
```

**Arguments**  

| name | description |
|---|---|
| version | the version of the documentation. default: package.json[version] + package.json[release-type] |

# Useful Links
The published documentation is hosted on GitHub (`gh-pages`) and can be found here: https://openanthem.github.io/nimbus-docs

Other helpful resources may be found within the [Nimbus Atlassian Wiki](https://anthemopensource.atlassian.net/wiki/spaces/OSS/pages).