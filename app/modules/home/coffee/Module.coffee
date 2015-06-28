define 'app/modules/home/js/Module', [
  'app/js/BaseModule'
  'app/js/Application'
  'app/modules/home/js/routers/Default'
], (BaseModule, Application, DefaultRouter) ->

  class homeModule extends BaseModule

    channelName: 'home'

    setRouters: ->
      @routers.DefaultRouter = new DefaultRouter channelName: @channelName

  Application.module "Home", homeModule
