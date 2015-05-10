define 'app/main', [
    'app/Application'
    'app/modules/main/Module'
], (
    Application
    MainModule
) ->

    Application.start()        
