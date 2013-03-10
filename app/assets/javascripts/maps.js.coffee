# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require laconic
#= require lodash
#= require backbone
#= require leaflet
#= require cartodb
#= require ./config
#= require ./router


window.onload = ->
  opts = 
    test: no
    config: config
    dispatcher: _.clone(Backbone.Events)

  mainRoute = new Router(opts)
  Backbone.history.start()
  
