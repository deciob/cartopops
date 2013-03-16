#= require ./models/city
#= require ./models/cities

class @Router extends Backbone.Router

  routes:
    "": "country"
    "country(/:country_code)(/:year)/": "country"

  initialize: (@config) ->
    @dataStrategy = @config.dataStrategy
    @fields_str = @config.cartodb_sql_fields
    @old_country_code = @config.default_country_code
    @old_year = @config.default_year
    @deferred = @getDeferred @get_sql(), @config.cartodb_user
    @dispatcher = @config.dispatcher
    @onDeferredDone @deferred, @dispatcher

  get_sql: ->
    "select #{@fields_str} from urban_agglomerations limit 2"

  # Gets a deferred from the cartodb sql API. 
  # When successful the deferred should return an object
  # with the following structure:
  # {time: 0.06, total_rows: xx, rows: Array[xx]}
  getDeferred: (sql, user, service) ->
    @dataStrategy.getDeferred sql, user, service

  # For each data.rows (cities) it calls @add_city.
  onDeferredDone: (deferred, dispatcher) ->
    @dataStrategy.onDeferredDone deferred, dispatcher

  # Called on navigation.
  # If country_code or year change the appropriate global event is fired.
  # If country or year is undefined use default values.
  country: (country_code, year) ->
    if country_code != @old_country_code
      country_code = country_code or @config.default_country_code
      @old_country_code = country_code
      @dispatcher.trigger "Router:country_code", country_code
    if year and year != @old_year
      year = year or @config.default_year
      @old_year = year
      @dispatcher.trigger "Router:year", year
      