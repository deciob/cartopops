
class @Cities extends Backbone.Collection

  model: City

  initialize: (@config) ->
    @dispatcher = @config.dispatcher
    @dispatcher.on "dataStrategy#onDeferredDone", @addCities
    

  addCities: (rows) =>
    _.each rows, @addCity, @

  # Creates a new city model and adds it to the cities collection.
  addCity: (element, index, list) ->
    city = new City element
    @add city
    



