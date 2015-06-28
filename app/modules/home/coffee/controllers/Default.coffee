define 'app/modules/home/js/controllers/Default', [
  'app/js/BaseController'
  'app/modules/home/js/views/Layout'
  'app/modules/home/js/views/Header'
  'app/modules/home/js/views/Home'
], (
  BaseController
  Layout
  Header
  HomeView
) ->

  class DefaultController extends BaseController

    channelName: 'home'

    mainLayoutClass: Layout

    homeLayout: HomeView

    showHome: ->
      @initLayout()
      @layout.getRegion('header').show new Header channelName: @channelName
      @homeLayout = new HomeView channelName: @channelName
      @homeLayout.render()
      @vent.trigger 'module:request', request: 'view:portfolio-carousel'

    setEvents: ->
      @vent.on 'response:view:portfolio-carousel', (view) =>
        @homeLayout.getRegion('portfolio').show view
