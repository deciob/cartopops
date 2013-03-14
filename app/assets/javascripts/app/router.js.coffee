#= require ./models/city
#= require ./models/cities

class @Router extends Backbone.Router

  routes:
    "": "country"
    "country(/:country_code)(/:year)/": "country"

  initialize: (@config) ->
    @fields_str = @config.cartodb_sql_fields
    @dispatcher = @config.dispatcher
    @cities = new Cities()
    @old_country_code = @config.default_country_code
    @old_year = @config.default_year
    if not @config.test
      deferred = @get_deferred(@get_sql())
      @initialize_data(deferred)
    
  get_carto: ->
    new cartodb.SQL(user: @config.cartodb_user)

  get_sql: ->
    "select #{@fields_str} from urban_agglomerations limit 2"

  # Gets a deferred from the cartodb sql API. 
  # When successful the deferred should return an object
  # with the following structure:
  # {time: 0.06, total_rows: xx, rows: Array[xx]}
  get_deferred: (sql) ->
    url = "http://" + @config.cartodb_user + 
      ".cartodb.com/api/v2/sql/?q=" + sql
    deferred = $.ajax
      dataType: "json"
      url: url

  # For each data.rows (cities) it calls @add_city.
  initialize_data: (deferred) ->
    deferred.complete( (data) =>
      _.each data.rows, @add_city, @
      @dispatcher.trigger "Router:cities_initialized", @cities
    ).error (errors) ->
      console.log "error:" + errors

  # Creates a new city model and adds it to the cities collection.
  add_city: (element, index, list) ->
    city = new City element
    @cities.add city

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
      