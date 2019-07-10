const semver = require('semver');

module.exports = {
    getArgs: function() {
        var args = {};
        process.argv.slice(2).forEach(function (arg) {
            var key = arg;
            var value = true;
            var splits = arg.split('=');
            if (splits.length > 1) {
                key = splits[0];
                value = arg.slice(arg.indexOf('=') + 1);
            }
            args[key] = value;
        });
        return args;
    },
    getReleaseType: function(version) {
        if (!this.isValidVersion(version)) {
            return undefined;
        }
        return version.substr(version.lastIndexOf('.') + 1);
    },
    isRelease: function(version) {
        if (!this.isValidVersion(version)) {
            return false;
        }
        let releaseType = this.getReleaseType(version);
        return 'BUILD-SNAPSHOT' !== releaseType;
    },
    isValidVersion: function (version) {
        if (!version) {
            return false;
        }
        let parts = version.split('.');
        if (parts.length === 3) {
            return semver.valid(version);
        } else if (parts.length === 4) {
            let releaseType = parts.pop();
            let semverVersion = parts.join('.');
            if (!semver.valid(semverVersion)) {
                return false;
            }
            return releaseType.match(/^BUILD-SNAPSHOT|RELEASE|M\d+/g);
        }
        return false;
    }
}