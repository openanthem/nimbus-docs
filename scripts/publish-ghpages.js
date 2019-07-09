const ghpages = require('gh-pages');
const fs = require("fs");
const tools = require('./tools');

const NPM_VERSION = process.env.npm_package_version;
const RELEASE_TYPE = process.env.npm_package_release_type;
const VERSION = `${NPM_VERSION}.${RELEASE_TYPE}`;

var args = tools.getArgs();

var version = args['version'] ? args['version'] : VERSION;
var releaseType = version.substr(version.lastIndexOf('.') + 1);
var shouldPublish = 'BUILD-SNAPSHOT' !== releaseType;

var options = {
    src: '**/*',
    branch: 'gh-pages',
    dest: `${version}`,
    remote: 'origin',
    message: `${version} updates`,
};

if (!shouldPublish) {
    console.log(`${version} has a release type of '${releaseType}'. Skipping publish step.`);
    return;
}

var dirToPublish = `dist/${version}`;
if (!fs.existsSync(dirToPublish)) {
    throw new Error(`Failed to publish content from '${dirToPublish}' because the directory does not exist. Did you run 'npm build' yet?`);
}
publish(dirToPublish, options);

function publish(dirToPublish, options) {
    var outLocation = `${options.remote}/${options.branch}`;
    console.log(`Publishing HTML content to ${outLocation}...`);
    ghpages.publish(dirToPublish, options, function(err) {
        if (err) {
            // handle error if necessary
        }
        console.log(`Pushed published content to ${outLocation}.`);
    });
}