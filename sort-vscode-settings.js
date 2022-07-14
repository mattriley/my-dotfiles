const settingsFile = './src/vscode-settings.json';
const settings = require(settingsFile);
const sortedKeys = Object.keys(settings).sort();
const sortedEntries = sortedKeys.map(k => [k, settings[k]]);
const sortedSettings = Object.fromEntries(sortedEntries);
const json = JSON.stringify(sortedSettings, null, 4);
require('fs').writeFileSync(settingsFile, json);
