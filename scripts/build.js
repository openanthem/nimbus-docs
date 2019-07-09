const shell = require('shelljs');
const prompt = require('prompt');
const tools = require('./tools');

const NPM_VERSION = process.env.npm_package_version;
const RELEASE_TYPE = process.env.npm_package_release_type;
const VERSION = `${NPM_VERSION}.${RELEASE_TYPE}`;

var args = tools.getArgs();
var version = args['version'] ? args['version'] : VERSION;
var quiet = args['quiet'] ? true : false;

// quiet mode
if (quiet) {
    build(version);

} else {
    
    var promptProperties = {};
    
    // Prompt for new version
    if (!args['version']) {
        promptProperties['newVersion'] = {
            description: `Enter the version`,
            default: `${VERSION}`,
            required: true
        };
    }

    // collect the user input
    prompt.start();
    prompt.get({ properties: promptProperties }, function (err, result) {
        if (!result) {
            return;
        }

        if (result.newVersion) {
            version = result.newVersion;
        }

        build(version);
    });
}

function build(version) {
    shell.exec(`./scripts/generate.sh -V ${version}`);
}