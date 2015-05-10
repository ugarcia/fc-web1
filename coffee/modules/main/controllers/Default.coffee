define 'app/modules/main/controllers/Default', [
    'marionette'
    'app/modules/main/views/Layout'
    'app/modules/main/views/Header'
    'app/modules/main/views/Content'
    'app/modules/main/models/Default'
], (
    Marionette
    Layout
    Header
    Content
    Model
) ->

    Marionette.Controller.extend

        layout: null

        doFoo: ->
            @initLayout()
            @layout.getRegion('header').show new Header
            @layout.getRegion('content').show new Content

        doBar: (id) ->
            @initLayout()
            @layout.getRegion('header').empty()
            @layout.getRegion('content').show new Content model: new Model id: id

        initLayout: ->
            if not @layout
                @layout = new Layout
                @layout.render()
