define 'app/modules/main/js/views/Footer', ['marionette', 'tpl!app/modules/main/templates/footer.html'], (Marionette, tpl) ->

    class Footer extends Marionette.ItemView

        template: (model) -> tpl model: model

