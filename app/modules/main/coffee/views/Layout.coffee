define 'app/modules/main/js/views/Layout', ['marionette'], (Marionette) ->

    class Layout extends Marionette.LayoutView

        template: false

        el: 'body'

        regions:
            navbar: '.fc-navbar'
            footer: '.fc-footer'
            header: '.fc-header'
            content: '.fc-content'
