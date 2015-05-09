require.config
   paths:
      jquery: '/bower_components/jquery/dist/jquery.min'
      underscore: '/bower_components/underscore/underscore'
      backbone: '/bower_components/backbone/backbone'
      marionette: '/bower_components/marionette/lib/backbone.marionette.min'
      app: '/js'
   shim:
      underscore:
         exports: '_'
      backbone:
         deps: ["underscore", "jquery"]
         exports: "Backbone"
      marionette:
         deps: ["backbone"]
         exports: "Marionette"
      common:
         deps: ["marionette"]

require ['app/main']
