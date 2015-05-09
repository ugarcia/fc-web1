define 'app/main', [
    'app/Application'
    'app/routers/MainRouter'
    'app/views/MainView'
], (
    Application
    MainRouter
    MainView
) ->
  Application.start()
