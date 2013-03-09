# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require leaflet
#= require cartodb


window.onload = ->
  cartodb.createVis "map", "http://examples-beta.cartodb.com/api/v1/viz/219/viz.json"