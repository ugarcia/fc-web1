define 'app/js/BaseLayout', ['marionette'], (Marionette) ->

  class BaseLayout extends Marionette.LayoutView

    template: false

    el: 'body'

    regions:
        navbar: '.fc-navbar'
        footer: '.fc-footer'
        header: '.fc-header'
        content: '.fc-content'
