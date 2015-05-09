define 'app/views/MainView', ['marionette'], (Marionette) ->
  Marionette.LayoutView.extend
    el: 'body'
    regions:
      navbar: '.fc-navbar'
      header: '.fc-header'
      content: '.fc-content'
      footer: '.fc-footer'