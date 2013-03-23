

@m.MapView = class Map extends Backbone.View

    el: "#map"

    initialize: (@config) ->
      @collection = @config.model
      @dispatcher = @config.dispatcher
      @listenTo @dispatcher, "dataStrategy#onDeferredDone", @initOverlay
      @render()
      
    initMap: ->
      L.map('map').setView [0, 0], 1

    initTileLayer: ->
      L.tileLayer(
        'https://tiles.mapbox.com/v3/deciob.map-lh230a22/{z}/{x}/{y}.png', 
        { maxZoom: 18 }
      )

    addCity: (c) ->
      circle = L.circle([c.latitude, c.longitude], 5,
        color: "red"
        fillColor: "#f03"
        fillOpacity: 0.5
      ).addTo(@map)

    initOverlay: (cities) ->
      _.each cities, @addCity, @

    # We are not rendering any View here, but simply delegating to Leaflet.
    render: ->
      @map = @initMap()
      base_layer = @initTileLayer()
      base_layer.addTo @map