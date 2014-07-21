(($) ->
  template = Handlebars.compile """
  <div class='ui-loading-overlay'>
    <div class='ui-loading-dot'></div>
    <div class='ui-loading-dot'></div>
    <div class='ui-loading-dot'></div>
  </div>
  """

  methods =
    destroy: ->
      $(this)
        .removeClass("ui-loading")
        .children(".ui-loading-overlay")
          .remove()

      this

  $.fn.loading = (options={}, args...)->
    # Call one of the plugin's methods
    if (options and methods[options])
      return methods[options].apply this, args

    options = $.extend true, {},
      el: this
      $el: $(this)
    , options

    $.each options.el, (i, el) ->
      $el = $(el)
      $el.addClass("ui-loading")

      if $el.css("position") not in ["absolute", "relative", "fixed"]
        $el.css
          position: "relative"

      $el.data("loading-state", true)

      # Append the loading_cover
      loading_cover = template({})

      $el.append loading_cover

    this
)(jQuery)

