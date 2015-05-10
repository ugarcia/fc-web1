define 'app/controllers/Default', [
    'marionette'
    'app/views/Layout'
    'app/views/Header'
    'app/views/Content'
    'app/views/Navbar'
    'app/views/Footer'
    'app/models/Default'
    'app/collections/Default'
], (
    Marionette
    Layout
    Header
    Content
    Navbar
    Footer
    Model
    Collection
) ->

    Marionette.Controller.extend

        layout: null

        home: ->
            @initLayout()
            @layout.getRegion('header').show new Header
            @layout.getRegion('content').show new Content

        initLayout: ->
            if not @layout
                @layout = new Layout        
                @layout.render()
                @layout.getRegion('navbar').show new Navbar
                @layout.getRegion('footer').show new Footer
