define 'app/modules/main/js/Module', [
  'app/js/BaseModule'
  'app/js/Application'
  'app/modules/main/js/routers/Default'
], (BaseModule, Application, DefaultRouter) ->

  class MainModule extends BaseModule

    channelName: 'main'

    setRouters: ->
      @routers.DefaultRouter = new DefaultRouter channelName: @channelName

    onStart: (options) ->
      super options
      @routers.DefaultRouter.controller.initLayout()

  Application.module "Main", MainModule
