define 'app/modules/main/js/controllers/Default', [
    'marionette'
    'app/modules/main/js/views/Layout'
    'app/modules/main/js/views/Navbar'
    'app/modules/main/js/views/Footer'
    'app/modules/main/js/views/Header'
    'app/modules/main/js/views/Content'
], (
    Marionette
    Layout
    Navbar
    Footer
    Header
    Content
) ->

    class Default extends Marionette.Controller

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