define 'app/modules/main/js/views/Content', ['marionette', 'tpl!app/modules/main/templates/content.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) => tpl model: model or {}
