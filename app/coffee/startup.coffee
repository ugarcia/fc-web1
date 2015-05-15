require.config
    paths:
        modernizr: '/bower_components/modernizr/modernizr'
        jquery: '/bower_components/jquery/dist/jquery.min'
        bootstrap: '/bower_components/bootstrap/dist/js/bootstrap.min'
        underscore: '/bower_components/underscore/underscore'
        backbone: '/bower_components/backbone/backbone'
        marionette: '/bower_components/marionette/lib/backbone.marionette.min'
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

require ['modernizr', 'bootstrap'], ->
    require [
        'app/js/Application'
        'app/modules/main/js/Module'
        'app/modules/cms/js/Module'
    ], (Application) -> Application.start()     