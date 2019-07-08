var shell = require('shelljs');

const NPM_VERSION = process.env.npm_package_version;
const RELEASE_TYPE = process.env.npm_package_release_type;
const VERSION = `${NPM_VERSION}.${RELEASE_TYPE}`;

console.log('Generating HTML content from asciidoc...');
shell.exec(`./scripts/generate.sh -V ${VERSION}`);

var ghpages = require('gh-pages');

var options = {
    src: '**/*',
    branch: 'gh-pages',
    dest: `${VERSION}`,
    message: `${VERSION} updates`,
};

var isRelease = 'BUILD-SNAPSHOT' !== RELEASE_TYPE;
var shouldDeploy = true;

if (isRelease) {
    options.tag = `v${VERSION}`;
}

if (shouldDeploy) {
    console.log('Publishing HTML content to gh-pages...');
    ghpages.publish(`dist/${VERSION}`, options, function(err) {
        throw err;
    });
}
