define 'app/views/Navbar', ['marionette', 'tpl!templates/navbar.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked!!!!"
            console.log evt
