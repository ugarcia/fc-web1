window.WP_API_Settings = 
    root: '/cms_api/wp-json'
    # root: 'https://cms.frontcoder.local'

require.config
    paths:
        modernizr: '/bower_components/modernizr/modernizr'
        jquery: '/bower_components/jquery/dist/jquery.min'
        bootstrap: '/bower_components/bootstrap/dist/js/bootstrap.min'
        underscore: '/bower_components/underscore/underscore'
        backbone: '/bower_components/backbone/backbone'
        marionette: '/bower_components/marionette/lib/backbone.marionette.min'
        tpl: '/bower_components/requirejs-tpl/tpl'
        wp_api: '/bower_components/wp-api-js/build/js/wp-api.min' 
        app: '/js'
        templates: '/templates'
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
        wp_api:
            deps: ["backbone"]

require ['modernizr', 'bootstrap', 'wp_api', 'app/main']
