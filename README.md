# Wistia Player Controls

It's really easy to add extra controls and functionality to your Wistia
videos using their Javascript API. http://wistia.com/doc/player-api

**Take a look at video.html and player.js to see how these examples work.**

## Custom Playback Speeds

The Wistia embed has an option called `playbackRate` that you can use to
adjust the speed of the video in HTML5. Be aware this doesn't work in Flash.

```javascript
wistiaEmbed.playbackRate(1.5);
```

To do this, all you need to do is have a set of links for the various
speeds and connect them with Javascript to set the playbackRate. I use
the `data-speed` attribute to do this in the example.

I've also included an example that saves the playback speed to a user
profile. It will make an AJAX call after the button is clicked to save
the preference.

To make the video automatically play at their saved speed preference,
just set the `data-speed` attribute on the
`data-behavior='video-controls'` tag like so:

```html
<ul class="nav nav-pills centered-pills" data-speed="1.5" data-name="1.5x" data-behavior="video-controls">
```

This way you don't have to make another AJAX request to load the default
and when the page renders the default speed can be ready to go.

## Skip Forward 30 seconds and Backward 30 seconds

This are really simple to add. You can create links to skip forwards and
backwards, then just simply set the time of the Wistia video to the
current time plus or minus 30 seconds.

```javascript
wistiaEmbed.time(wistiaEmbed.time() + 30);
```

Don't worry about going past the ends of the video, Wistia and the
browser won't care if you attempt to set the time out of bounds. They'll
take care of that for you.

## Autoplay

Autoplay is the easiest of all. Right after your embed code JS, just add
the play() call and you're all set.

```javascript
wistiaEmbed = Wistia.embed("9z0afs4cla", {
  videoFoam: true,
});

wistiaEmbed.play()
```

Ideally, you should only have videos autoplay when the user expects it
to, such as when they click on a thumbnail. This is an ideal user
experience for everyone so they don't have videos playing in the
background on random tabs.

## Author

That's it! If you have any questions, create an issue or add
