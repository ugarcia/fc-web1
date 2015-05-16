define 'app/modules/cms/js/views/Layout', ['marionette'], (Marionette) ->

    class Layout extends Marionette.LayoutView

        template: false

        el: 'body'

        regions:
            header: '.fc-header'
            content: '.fc-content'
            modal: '.fc-modal'
