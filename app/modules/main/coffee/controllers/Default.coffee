define 'app/modules/main/js/controllers/Default', [
  'app/js/BaseController'
  'backbone'
  'app/modules/main/js/views/Layout'
  'app/modules/main/js/views/Navbar'
  'app/modules/main/js/views/Footer'
  'app/modules/main/js/views/Header'
  'app/modules/main/js/views/Content'
], (
  BaseController
  Backbone
  Layout
  Navbar
  Footer
  Header
  Content
) ->

  class Default extends BaseController

    channelName: 'main'

    mainLayoutClass: Layout

    home: ->
      @initLayout()
      @layout.getRegion('header').show new Header
      @layout.getRegion('content').show new Content

    startLayout: ->
      path = @getPath()
      @layout.getRegion('navbar').show new Navbar model: new Backbone.Model path: path
      @layout.getRegion('footer').show new Footer
