

@m.MapView = class Map extends Backbone.View

    el: "#map"

    initialize: (@config) ->
      @collection = @config.model
      @dispatcher = @config.dispatcher
      @render()
      
    initMap: ->
      L.map('map').setView [0, 0], 1

    initTileLayer: ->
      L.tileLayer(
        'https://tiles.mapbox.com/v3/deciob.map-lh230a22/{z}/{x}/{y}.png', 
        { maxZoom: 18 }
      )

    # We are not rendering any View here, but simply relying on Leaflet.
    render: ->
      map = @initMap()
      base_layer = @initTileLayer()
      base_layer.addTo map