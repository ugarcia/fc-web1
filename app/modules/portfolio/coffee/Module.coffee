define 'app/modules/portfolio/js/Module', [
  'app/js/BaseModule'
  'app/js/Application'
  'app/modules/portfolio/js/routers/Default'
], (BaseModule, Application, DefaultRouter) ->

  class PortfolioModule extends BaseModule

    channelName: 'portfolio'

    setRouters: ->
      @routers.DefaultRouter = new DefaultRouter channelName: @channelName

  Application.module "Portfolio", PortfolioModule
