define 'app/modules/main/views/Content', ['marionette', 'tpl!templates/modules/main/content.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) => tpl model: model or {}

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked COOOONTENT!!!!!!!!"
            console.log evt
