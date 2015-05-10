define 'app/views/Content', ['marionette', 'tpl!templates/content.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

        events:
           'click button': 'buttonClickHandler'
           
        buttonClickHandler: (evt) ->
            alert "CLicked!!!!"
            console.log evt
