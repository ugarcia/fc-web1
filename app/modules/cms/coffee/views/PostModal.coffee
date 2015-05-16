define 'app/modules/cms/js/views/PostModal',  ['marionette', 'tpl!app/modules/cms/templates/post-modal.html'], (Marionette, tpl) ->

    Marionette.ItemView.extend

        template: (model) => tpl model: model or {}

        events:
            'submit form': 'submitHandler'
           
        submitHandler: (evt) ->
            evt.preventDefault()
            formData = new FormData
            formData.append 'title', 'Test post'
            formData.append 'content', 'Post for testing purposes'
            formData.append 'name', 'dummy'
            formData.append 'email', 'dummy@frontcoder.com'
            API.createPost formData
              .then (response) -> console.log "Posted: ", response.post.title
