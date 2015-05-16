define 'app/modules/main/js/views/Content', ['marionette', 'tpl!app/modules/main/templates/content.html'], (Marionette, tpl) ->

    class Content extends Marionette.ItemView

        template: (model) => tpl model: model or {}
