(($) ->
  methods =
    destroy: ->
      $(this)
        .removeClass("loading")
        .children(".loading-cover")
          .remove()

      this

    update: (progress) ->
      $(this).find('.progress').html(progress)


  $.fn.loading = (options={}, args...)->
    # Call one of the plugin's methods
    if (options and methods[options])
      return methods[options].apply this, args

    options = $.extend true, {},
      el: this
      $el: $(this)
      class: 'loading-cover'
      display: 'inline-block'
      progress:
        class: 'progress'
        value: ''
        css:
          position: 'absolute'
          zIindex: 9999999
          left: 0
          top: '50%'
          display: 'inline-block'
          marginTop: '-0.5em'
          width: '100%'
          textAlign: 'center'
      css:
        position: "absolute"
        height: "100%"
        width: "100%"
        top: 0
        left: 0
        background: "#fff"
        zIndex: 9999999
      spinner:
        lines: 12
        length: 10
        width: 6
        radius: 18
        color: '#000'
        speed: 1
        trail: 60
        shadow: false
        hwaccel: true
        className: 'spinner'
        zIndex: 2e9
        top: 'auto'
        left: 'auto'
    , options

    $.each options.el, (i, el) ->
      $el = $ el
      $el.addClass("loading")

      if $el.css("position") not in ["absolute", "relative", "fixed"]
        $el.css
          position: "relative"

      $el.data("loading-state", true)

      # Append the loading_cover
      loading_cover = $ "<div />",
        class: options.class

      loading_cover.css options.css

      spinner = new Spinner options.spinner

      $el.append loading_cover

      spinner.spin loading_cover[0]

      $el.find('.spinner').css
        position: 'absolute'
        left: '50%'
        top: '50%'


      # Append the progress div
      $progress = $ "<div />",
        class: options.progress.class

      $progress.html options.progress.value
      $progress.css options.progress.css
      loading_cover.append $progress

      $el.find(".spinner").css "display", options.display

    this
)(jQuery)
