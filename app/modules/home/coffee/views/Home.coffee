define 'app/modules/home/js/views/Home', ['marionette', 'tpl!app/modules/home/templates/content.html'], (Marionette, tpl) ->

    class Home extends Marionette.LayoutView

#        el: 'body'

        template: (model) -> tpl model: model or {}

        regions:
            portfolio: '.fc-portfolio'
            misc: '.fc-misc'
