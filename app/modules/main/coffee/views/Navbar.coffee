define 'app/modules/main/js/views/Navbar', ['marionette', 'tpl!app/modules/main/templates/navbar.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked!!!!"
            console.log evt
