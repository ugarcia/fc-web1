define 'app/modules/main/js/views/Header', ['marionette', 'app/js/Application', 'tpl!app/modules/main/templates/header.html'], (Marionette, Application, tpl) ->

    class Header extends Marionette.ItemView

        template: (model) -> tpl model: model or {}

        events:
            'click .fc-navigation': 'navigationHandler'
            
        navigationHandler: (evt) ->
            evt.preventDefault()
            Application.vent.trigger 'navigation', {target: $(evt.currentTarget).data('target')}
