define 'app/modules/cms/js/views/Post', ['marionette', 'tpl!app/modules/cms/templates/post.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) => tpl model: model or {}

        events:
            'click button': 'buttonClickHandler'
            
        buttonClickHandler: (evt) ->
            alert "CLicked COOOONTENT!!!!!!!!"
            console.log evt
