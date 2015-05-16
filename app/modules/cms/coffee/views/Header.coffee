define 'app/modules/cms/js/views/Header', ['marionette', 'tpl!app/modules/cms/templates/header.html'], (Marionette,  tpl) ->

    Marionette.ItemView.extend

        template: (model) -> tpl model: model or {}

        events:
            'click .fc-modal-trigger': 'openModalHandler'

        openModalHandler: (evt) =>
            console.log evt
            console.log @

