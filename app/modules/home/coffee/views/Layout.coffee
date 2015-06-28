define 'app/modules/home/js/views/Layout', ['app/js/BaseLayout'], (BaseLayout) ->

  class Layout extends BaseLayout

    regions:
      header: '.fc-header'
      content: '.fc-content'
      modal: '.fc-modal'
