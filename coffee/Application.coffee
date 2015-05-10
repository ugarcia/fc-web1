define 'app/Application', ['backbone', 'marionette', 'app/routers/Default'], (Backbone, Marionette, DefaultRouter) ->

    class Application extends Marionette.Application

        initialize: (options) ->
            console.log "App initialized", options ? 'No options'
            @vent.on 'goToMainBar', (data) =>  @module('Main').DefaultRouter.navigate "main/bar/#{data.id}", {trigger: true}
            @DefaultRouter = new DefaultRouter
            @on 'start', ->
                @DefaultRouter.controller.initLayout()
                Backbone.history.start
                    pushState: true
                    root: '/'

    window.Application or= new Application key: 'value'
