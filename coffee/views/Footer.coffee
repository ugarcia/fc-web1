define 'app/views/Footer', ['marionette', 'tpl!templates/footer.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked!!!!"
            console.log evt
