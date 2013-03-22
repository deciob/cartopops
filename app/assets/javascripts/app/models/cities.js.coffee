#= require app/models/city

City = @m.City

@m.Cities = class Cities extends Backbone.Collection

  model: City

  initialize: (@config) ->
    @dispatcher = @config.dispatcher
    @listenTo @dispatcher, "dataStrategy#onDeferredDone", @addCities

  # Creates a new city model and adds it to the cities collection.
  addCity: (element, index, list) ->
    city = new @model element
    @add city

  addCities: (rows) =>
    _.each rows, @addCity, @
    



