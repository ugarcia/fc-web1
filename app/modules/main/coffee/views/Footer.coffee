define 'app/modules/main/js/views/Footer', ['marionette', 'tpl!app/modules/main/templates/footer.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

