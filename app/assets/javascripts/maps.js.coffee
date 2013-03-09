# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require laconic
#= require lodash
#= require backbone
#= require leaflet
#= require cartodb


window.onload = ->

  #cartodb.createVis "map", "http://deciob.cartodb.com/api/v1/viz/5381/viz.json"


  map = new L.Map("map",
    center: [0, 0]
    zoom: 2
  )
  #cartodb.createLayer(map, 
  #  #"http://deciob.cartodb.com/api/v1/viz/5381/viz.json")
  #  'http://examples-beta.cartodb.com/api/v1/viz/766/viz.json')
  #.on "error", (err) ->
  #  alert "some error occurred: " + err

  L.tileLayer('https://tiles.mapbox.com/v3/deciob.map-lh230a22/{z}/{x}/{y}.png')
    .addTo(map)

  # Does not work
  #cartodb.createLayer(map, 'http://deciob.cartodb.com/api/v1/viz/5381/viz.json')

  
  add_overlay = (element, index, list) ->
    lat = element.latitude
    lng = element.longitude
    L.circle([lat, lng], 20).addTo(map)


  sql = new cartodb.SQL(user: "deciob")
  sql.execute("select * from urban_agglomerations"
  ).done((data) ->
    _.each data.rows, add_overlay
  ).error (errors) ->
    # errors contains a list of errors
    console.log "error:" + errors
