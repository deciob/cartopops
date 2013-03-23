#= require app/models/city

City = @m.City

@m.Cities = class Cities extends Backbone.Collection

  model: City

  initialize: (@config) ->
    @dispatcher = @config.dispatcher
    @listenTo @dispatcher, "dataStrategy#onDeferredDone", @addCities

  # Creates a new city model and adds it to the cities collection.
  # Not very sure about this. The alternative would be to use the 
  # backbone's built-in `fetch` method. Trying this instead, so 
  # I can handle the deferred with more flexibility within a strategy:
  # app_data_strategy
  # spec_data_strategy
  addCity: (element, index, list) ->
    city = new @model element
    @add city

  addCities: (rows) =>
    _.each rows, @addCity, @
    



