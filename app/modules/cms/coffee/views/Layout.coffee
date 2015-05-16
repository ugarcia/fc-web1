define 'app/modules/cms/js/views/Layout', ['marionette'], (Marionette) ->

    Marionette.LayoutView.extend

        template: false

        el: 'body'

        regions:
            header: '.fc-header'
            content: '.fc-content'
            modal: '.fc-modal'
