const shell = require('shelljs');
const prompt = require('prompt');
const tools = require('./tools');

const NPM_VERSION = process.env.npm_package_version;
const RELEASE_TYPE = process.env.npm_package_release_type;
const VERSION = `${NPM_VERSION}.${RELEASE_TYPE}`;

var args = tools.getArgs();

if (!tools.isProvidedArgument('debug'), args) {
    console.debug = function() {}
}

// START initialize script arguments
console.debug('Initializing script arguments...');
var version;
if (tools.isProvidedArgument('version', args)) {
    version = args['version'];
    console.debug('-> command line argument provided for "version"...');
    console.debug('---> provided argument was: ' + args['version']);
    console.debug('---> new value is: ' + version);
} else {
    console.debug('-> setting "version" from package.json "version" and "release-type"...');
    console.debug('---> package.json "version" is: ' + NPM_VERSION);
    console.debug('---> package.json "release-type" is: ' + RELEASE_TYPE);
    console.debug('---> new value is: ' + VERSION);
    version = VERSION;
}

var updateLatest;
if (tools.isProvidedArgument('update-latest', args)) {
    updateLatest = (args['update-latest'] == 'y' || args['update-latest'] === undefined) ? true : false;
    console.debug('-> command line argument provided for "updateLatest"...');
    console.debug('---> provided argument was: ' + args['update-latest']);
    console.debug('---> new value is: ' + updateLatest);
}

// START script argument validation
if (!tools.isValidVersion(version)) {
    throw new Error(`The version '${version}' is not a valid version.`);
}
console.debug('Finished initializing script arguments.');
// END script argument validation
// END initialize script arguments

// START script execution logic
if (tools.isProvidedArgument('quiet', args)) {
    console.debug('Building documentation in quiet mode...');
    build(version, updateLatest);

} else {
    console.debug('Building documentation in interactive mode...');
    console.debug('-> version: ' + version);
    console.debug('-> updateLatest: ' + updateLatest);
    var promptProperties = {};

    // Prompt for new version
    if (!tools.isProvidedArgument('version', args)) {
        promptProperties['newVersion'] = {
            description: `Enter the version`,
            default: `${VERSION}`,
            conform: function(version) {
                return tools.isValidVersion(version);
            },
            message: `Please enter a valid version. (x.y.z or x.y.z.BUILD-SNAPSHOT, x.y.z.M#, x.y.z.RELEASE)`,
            required: true
        };
    }

    if (!updateLatest) {
        promptProperties['updateLatest'] = {
            description: `Should the generated documentation also be used as latest?`,
            default: `n`,
            pattern: /y|n/,
            message: 'Please enter either "y" for yes, or "n" for no.',
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
            console.debug('-> overriding "version"...');
            console.debug('---> previous value was: ' + version);
            version = result.newVersion;
            console.debug('---> new value is: ' + version);
        }

        if (result.updateLatest == 'y') {
            console.debug('-> overriding "updateLatest"...');
            console.debug('---> previous value was: ' + updateLatest);
            updateLatest = true;
            console.debug('---> new value is: ' + updateLatest);
        }

        build(version, updateLatest);
    });
}
// END script execution logic

function build(version, updateLatest) {
    console.debug('Starting documentation build...')
    console.debug('-> version: ' + version);
    console.debug('-> updateLatest: ' + updateLatest);
    shell.exec(`./scripts/generate.sh -V ${version}`);
    console.log(`Successfully generated documentation for ${version}. Contents can be found in "dist/${version}".`);
    if (updateLatest) {
        shell.exec(`mkdir -p ./dist/latest`);
        shell.exec(`cp -f -R ./dist/${version}/* ./dist/latest`);
        console.log(`Successfully updated "latest" documentation with the generated ${version} documentation. Contents can be found in "dist/latest`);
    }
    console.debug('Finished documentation build.')
}