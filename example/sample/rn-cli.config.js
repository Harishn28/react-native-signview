'use strict';

const path = require('path');

const reactNativeSignview = path.resolve(__dirname, '..', '..');

const installedDependencies = require("./package.json").dependencies;

const extraNodeModules = {};
Object.keys(installedDependencies).forEach(dep => {
  extraNodeModules[dep] = path.resolve(__dirname, "node_modules", dep);
});

const installedDevDependencies = require("./package.json").devDependencies;

Object.keys(installedDevDependencies).forEach(dep => {
  extraNodeModules[dep] = path.resolve(__dirname, "node_modules", dep);
});

module.exports = {
  watchFolders: [path.resolve(__dirname, 'node_modules'), reactNativeSignview],
  resolver: {
    extraNodeModules: extraNodeModules
  }
};

