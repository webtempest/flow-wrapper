Package.describe({
  name: 'mplatts:flow-wrapper',
  version: '0.1.0',
  summary: 'Wraps Flow Router, allowing you to define all routes in a simple object',
  git: 'https://github.com/webtempest/flow-wrapper',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.3');
  api.use('coffeescript');
  api.use('kadira:flow-router');
  api.use('reactive-dict');
  api.use('underscore');
  api.addFiles([
    'flow-wrapper.coffee'
  ]);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('mplatts:flow-wrapper');
  api.addFiles('flow-wrapper-tests.js');
});
