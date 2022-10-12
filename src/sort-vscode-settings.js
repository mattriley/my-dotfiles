const [target] = require('process').argv.slice(2);
const settings = require(target);
const sortedKeys = Object.keys(settings).sort();
const sortedEntries = sortedKeys.map(k => [k, settings[k]]);
const sortedSettings = Object.fromEntries(sortedEntries);
const json = JSON.stringify(sortedSettings, null, 4);
require('fs').writeFileSync(target, json);
