define 'app/modules/cms/js/views/Posts', ['marionette', 'app/modules/cms/js/views/Post', 'tpl!app/modules/cms/templates/post.html'], (Marionette, PostView, tpl) ->

    Marionette.CollectionView.extend

        childView: PostView

        # template: (collection) => tpl collection: collection or {}

        events:
            'click button': 'buttonClickHandler'
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
            # alert "CLicked!!!!"
            # console.log evt

        buttonClickHandler: (evt) ->
            alert "CLicked COOOONTENT!!!!!!!!"
            console.log evt
