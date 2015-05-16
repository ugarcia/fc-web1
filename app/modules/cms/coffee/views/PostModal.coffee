define 'app/modules/cms/js/views/PostModal',  ['marionette', 'wreqr', 'tpl!app/modules/cms/templates/post-modal.html', 'ckeditor'], (Marionette, Wreqr, tpl) ->

    class PostModal extends Marionette.ItemView

        channelName: 'cms'

        vent: null

        options: null

        template: (model) => tpl model: model or {}

        events:
            'submit form': 'submitHandler'
        
        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent

        submitHandler: (evt) ->
            evt.preventDefault()
            form = $(evt.target)
            fields = ['title', 'content']
            @model.set key, form.find("[name=#{key}]").val() for key in fields
            @model.save @model.attributes, success: =>
                @vent.trigger 'collection:update:posts'
                form.closest('.fc-modal').modal 'hide'

        onShow: ->
            CKEDITOR.replace 'fc-post-content-field',
                customConfig: ''
                removePlugins: 'save'
