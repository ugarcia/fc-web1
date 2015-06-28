define 'app/modules/main/js/views/Navbar', ['marionette', 'tpl!app/modules/main/templates/navbar.html'], (Marionette, tpl) ->

    class Navbar extends Marionette.ItemView

        template: (model) -> tpl model: model

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            console.log evt
