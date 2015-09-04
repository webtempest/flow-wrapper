# webtempest:flow-wrapper

Wraps [Flow Router](https://github.com/kadirahq/flow-router), allowing you to define all basic routes in a simple object.

## Route syntax:

```js
// No login needed:
"path": "name=layout>template"

// Requires login (notice the exclamation mark '!')
"path": "name!=layout>template"
```

## Example

`routes.js`

```js
new FlowWrapper({

  routes: {
    "/": "home=layout>home",
    "/needsLogin": "profile!=layouts>profile"
  }
});
```

`layout.html`

```html
<template name="layout">
  {{> nav}}

  {{#if loggingIn}}
    {{> Template.dynamic template='loadingTemplate'}}
  {{else}}
    {{> Template.dynamic template=content}}
  {{/if}}

  {{>footer}}
</template>
```

`logging_in_helper.js`

```js
Template.registerHelper('loggingIn', function(){
  Meteor.loggingIn();
});
```

And then you'd have `home` and `profile` templates that load within the layout depending on the route.

## Options

Options (with defaults) you can pass when creating a new FlowWrapper:

```js
// These are defaults:
new FlowWrapper({
  dynamicTemplateName: 'content',
  accessDeniedTemplate: 'accessDenied',
  loadingTemplate: 'loading',

  routes: {}
})
```

## Custom Routes

Just use normal Flow Router syntax if you want custom behaviour. This is for basic routes that uses a layout with one dynamic template.

## Login procedure

This has a unique way of logging in. Usually if you hit a protected page you get redirected to a login screen. Then upon login you're redirected back to the original page you were after. This instead keeps you on the same route - so if you're trying to access `/profile` it will stay on that route while you login, and once logged in the `profile` template then gets rendered. This avoids the need for redirecting and storing the desired path.
