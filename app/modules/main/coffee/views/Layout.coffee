define 'app/modules/main/js/views/Layout', ['marionette'], (Marionette) ->

    Marionette.LayoutView.extend

        template: false

        el: 'body'

        regions:
            navbar: '.fc-navbar'
            footer: '.fc-footer'
            header: '.fc-header'
            content: '.fc-content'
