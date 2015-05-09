define 'app/Application', ['marionette'], (Marionette) ->
  class Application extends Marionette.Application
    initialize: (options) ->
        console.log "App initialized", options
  window.Application or= new Application
