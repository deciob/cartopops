# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require config
#= require app/models/cities
#= require app/router

window.onload = ->
  config = @m.config
  cities = new @m.Cities config
  mainRoute = new @m.Router config
  Backbone.history.start()
  