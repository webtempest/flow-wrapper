# Flow Wrapper

Wraps [Flow Router](https://github.com/kadirahq/flow-router), allowing you to define all basic routes in a simple object.

## Example

routes.js

```js
new FlowWrapper({

  routes: {
    "/": "home=layout>home",
    "/needsLogin": "protected!=layoutsPublic>publicProtected"
  }
});
```

layout.html

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


## Route syntax:

```js
// No login needed:
"path": "name=layout>template"

// Requires login (notice the exclamation mark '!')
"path": "name!=layout>template"
```

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
