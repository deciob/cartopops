#= require spec_helper
#= require spec_config
#= require config
#= require app/router
#= require app/models/cities


# chai-backbone
#model.should.trigger("change", with: [model]).when ->
#model.set attribute: "value"

config = _.extend(@m.config, @m.spec_config)
cities = new @m.Cities config

describe "Cities#addCities", ->
  
  before ->
    # Note: setting up the spy before calling the Router.
    sinon.spy cities, "addCities"
    cities.listenTo config.dispatcher, "dataStrategy#onDeferredDone", 
      cities.addCities
    mainRoute = new Router config
  
  after ->
    cities.addCities.restore()

  # As it is, this one looks a bit useless.
  it "addCities should only be called once after router initialization", ->
    cities.addCities.should.have.been.calledOnce

  it "argument to addCity equals response.rows", ->
    spyCall = cities.addCities.getCall 0
    rows = JSON.stringify JSON.parse(config.fake_city_response).rows
    rows.should.equal( JSON.stringify(spyCall.args[0]) )


#describe "Cities#addCity", ->
#  
#  before ->
#    # Note: setting up the spy before calling the Router.
#    sinon.spy cities, "addCity"
#    config.dispatcher.on "dataStrategy#onDeferredDone", cities.addCities
#    mainRoute = new Router config
#  
#  after ->
#    cities.addCity.restore()
#    
#  mainRoute = new Router config
#  config.dispatcher.on "dataStrategy#onDeferredDone", cities.addCities
#  #mainRoute = new Router config
#
#  #afterEach ->
#  #  spy.restore()

  
    