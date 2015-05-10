define 'app/views/Header', ['marionette', 'tpl!templates/header.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked!!!!"
            console.log evt
