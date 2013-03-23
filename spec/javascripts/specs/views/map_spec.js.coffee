#= require spec_helper
#= require spec_config
#= require config
#= require app/router
#= require app/views/map_view


config = _.extend(@m.config, @m.spec_config)
#mainRoute = new Router(config)
#Backbone.history.start()

spec = {}

describe "MapView#onDeferredDone", ->

  beforeEach ->
    # DOM setup
    window.page = $("#konacha")
    page.append('<div id="map" style="height: 380px;"></div>')
    # View setup
    spec.mapView = mapView = new window.m.MapView config
    #sinon.spy mapView, "initOverlay"  # Does not work?
    # Main route called after because it immediately resolves the deferred.
    # This looks all very messy!
    spec.mainRoute = new Router(config)

    
    
  afterEach ->
    spec.mapView = no
    spec.mainRoute = no
    #spec.mapView.initOverlay.restore()

  #it "argument to addCity equals response.rows", ->
  #  mapView = spec.mapView
#
  #  spec.mainRoute.deferred.done( (data) =>
  #    console.log 'LLLLLL'
  #    spyCall = mapView.initOverlay.getCall 0
  #    console.log spyCall
  #  )
  #  console.log 'LLLxxx'
  #  #mapView.initOverlay config.fake_city_response.rows
  #  #spyCall = mapView.initOverlay.getCall 0
  #  #console.log spyCall
#
  #  #rows = JSON.stringify JSON.parse(config.fake_city_response).rows
  #  #rows.should.equal( JSON.stringify(spyCall.args[0]) )

