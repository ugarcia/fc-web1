define 'app/modules/cms/js/views/Posts', ['marionette', 'app/modules/cms/js/views/Post', 'tpl!app/modules/cms/templates/post.html'], (Marionette, PostView, tpl) ->

    Marionette.CollectionView.extend

        childView: PostView

        # template: (collection) => tpl collection: collection or {}
