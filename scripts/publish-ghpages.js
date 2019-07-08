var shell = require('shelljs');

const NPM_VERSION = process.env.npm_package_version;
const RELEASE_TYPE = process.env.npm_package_release_type;
const VERSION = `${NPM_VERSION}.${RELEASE_TYPE}`;

shell.exec(`./scripts/generate.sh -V ${VERSION}`);