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
    }
}