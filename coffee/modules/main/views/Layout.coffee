define 'app/modules/main/views/Layout', ['marionette'], (Marionette) ->

    Marionette.LayoutView.extend

        template: false

        el: 'body'

        regions:
            header: '.fc-header'
            content: '.fc-content'
