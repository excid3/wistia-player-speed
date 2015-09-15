class Video
  constructor: (wistia) ->
    @wistia = wistia

    # Set the default speed to 1x
    @speed = 1.0

    @wistia.ready =>
      @setEvents()
      if @html5_player()
        @setDefaultSpeed()
        @setupPlaybackSpeedLinks()
        @setupPlayerSpeed()
      else
        # Hide controls because we're using the flash player
        @hidePlaybackSpeedControls()

  flash_player: ->
    @wistia.data.embedType == "flash"

  html5_player: ->
    !@flash_player()

  hideControls: ->
    $("[data-behavior='video-controls']").hide()

  # Handle the forward and backward links
  setEvents: ->
    $("[data-behavior='skip-forward']").on "click", @skipForward
    $("[data-behavior='skip-backward']").on "click", @skipBackward

  skipForward: =>
    @wistia.time @wistia.time() + 30

  skipBackward: =>
    @wistia.time @wistia.time() - 30

  setupPlayerSpeed: ->
    # Set the speed on play in case it gets reset (Safari)
    @wistia.bind "play", =>
      @wistia.playbackRate @speed

  setDefaultSpeed: ->
    $default = $("[data-behavior='video-controls']")
    @setSpeed $default.data("speed"), $default.data("name")

  setupPlaybackSpeedLinks: ->
    dropdown = $("[data-behavior='video-speed-dropdown']")
    dropdown.find("a").on "click", (e) =>
      e.preventDefault()
      $target = $(e.currentTarget)
      speed   = $target.data("speed")
      label   = $target.data("name")
      @setSpeed speed, label
      @saveSpeedDefault speed

  setSpeed: (speed, label) ->
    @speed = parseFloat(speed)

    # Set speed immediately if already playing
    @wistia.playbackRate @speed

    # Update dropdown label
    $("[data-behavior='video-speed-button']").text("Speed #{label}") if label

    # Display check mark on the selected one
    dropdown = $("[data-behavior='video-speed-dropdown']")
    dropdown.find("li a span").remove()
    dropdown.find("li a[data-speed='#{speed}']").prepend("<span class='pull-right'><i class='fa fa-check'></i></span>")

  saveSpeedDefault: (speed) ->
    return if $("meta[name='user']").length == 0

    $.ajax
      url: "/users"
      data:
        user:
          playback_speed: speed
      dataType: "JSON"
      method: "PATCH"

jQuery ->
  if wistiaEmbed?
    video = new Video(wistiaEmbed)

