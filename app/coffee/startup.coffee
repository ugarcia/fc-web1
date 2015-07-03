require.config
  paths:
    modernizr: '/bower_components/modernizr/modernizr'
    jquery: '/bower_components/jquery/dist/jquery.min'
    bootstrap: '/bower_components/bootstrap/dist/js/bootstrap.min'
    underscore: '/bower_components/underscore/underscore'
    backbone: '/bower_components/backbone/backbone'
    wreqr: '/bower_components/backbone.wreqr/lib/backbone.wreqr.min'
    marionette: '/bower_components/marionette/lib/backbone.marionette.min'
    ckeditor: '/bower_components/ckeditor/ckeditor'
    tpl: '/bower_components/requirejs-tpl/tpl'
    app: '/app'
  shim:
    bootstrap:
      deps: ['jquery']
    underscore:
      exports: '_'
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"
    marionette:
      deps: ["backbone"]
      exports: "Marionette"

require [
  'app/js/Application'
  'app/modules/main/js/Module'
#  'app/modules/cms/js/Module'
  'app/modules/portfolio/js/Module'
  'app/modules/home/js/Module'
  'modernizr'
  'bootstrap'
], (Application) -> Application.start()
