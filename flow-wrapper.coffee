class @FlowWrapper
  # FlowWrapper.routes
  #   "/": "home!=publicLayout>publicHome"
  #   "/protected": "protected!=publicLayout>publicProtected"

  constructor: (options) ->
    @options = _.defaults options,
      dynamicTemplateName: 'content'
      accessDeniedTemplate: 'accessDenied'
      loadingTemplate: 'loading'

    if options.routes
      @generate(options.routes)

  routes: (routes) ->
    @generate(routes)

  generate: (routes) ->
    _(routes).each (routeString, path) =>
      requiresAdmin = false
      layout = routeString.match(/\=(.*?)>/)[1]
      content = routeString.match(/>(.*?)$/)[1]
      name = routeString.match(/^(.*?)=/)[1]

      if name.match /!/
        requiresAdmin = true
        name = name.slice 0,-1

      self = @
      FlowRouter.route path,
        name: name
        action: ->
          layoutOptions = {}
          if requiresAdmin
            Tracker.autorun ->
              return unless FlowRouter.getRouteName() == name
              if Meteor.isServer
                user = this.userId
              
              if Meteor.isClient
                user = Meteor.user()

              if user
                layoutOptions[self.options.dynamicTemplateName] = content
                BlazeLayout.render(layout, layoutOptions)
              else
                layoutOptions[self.options.dynamicTemplateName] = self.options.accessDeniedTemplate
                BlazeLayout.render(layout, layoutOptions)
          else
            layoutOptions[self.options.dynamicTemplateName] = content
            BlazeLayout.render(layout, layoutOptions)
