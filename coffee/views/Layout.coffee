define 'app/views/Layout', ['marionette'], (Marionette) ->

    Marionette.LayoutView.extend

        template: false
        
        el: 'body'

        regions:
            navbar: '.fc-navbar'
            header: '.fc-header'
            content: '.fc-content'
            footer: '.fc-footer'