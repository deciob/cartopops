
class @Router extends Backbone.Router

  routes:
    "": "country"
    "country(/:code)(/:year)/": "country"

  initialize: ->
    console.log "Router initialized"

  country: (code, year) ->
    code = code or "world"
    year = year or 1950
    console.log "Hellow #{code}"