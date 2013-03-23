# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require config
#= require app/models/cities
#= require app/views/map_view
#= require app/router


# Possible problem: 
# mainRoute fires an ajax call that, when resolved, 
# expects the mapView to be in place! 

config = @m.config
cities = new @m.Cities config
mainRoute = new @m.Router config
Backbone.history.start()
config.collection = cities

# Views need the DOM to be loaded.
window.onload = ->
  mapView = new @m.MapView config
  