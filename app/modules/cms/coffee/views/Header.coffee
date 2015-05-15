define 'app/modules/cms/js/views/Header', ['marionette', 'app/js/Application', 'tpl!app/modules/cms/templates/header.html'], (Marionette, Application, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model or {}

        events:
            'click button': 'buttonClickHandler'
            'click a': 'linkClickHandler'

        buttonClickHandler: (evt) ->
            alert "CLicked Mainnnnn!!!!"
            console.log evt
            
        linkClickHandler: (evt) ->
            evt.preventDefault()
            Application.vent.trigger 'goToMainBar', {id: 'whatever!!'}
