#= require sinon
#= require sinon-chai
#= require chai-changes
#= require chai-backbone
#= require chai-factories

#= require ../../spec_helper
#= require lodash
#= require backbone

## require ../../../../app/assets/javascripts/namespace
## require ../../../../app/assets/javascripts/libs/data_strategy
#= require ../../../../app/assets/javascripts/app/router

#= require config
#= require ../../spec_config

# chai-backbone
#model.should.trigger("change", with: [model]).when ->
#model.set attribute: "value"

config = _.extend(@m.config, @m.spec_config)
cities = new Cities config

describe "Cities#addCities", ->
  
  before ->
    # Note: setting up the spy before calling the Router.
    sinon.spy cities, "addCities"
    config.dispatcher.on "dataStrategy#onDeferredDone", cities.addCities
    mainRoute = new Router config
  
  after ->
    cities.addCities.restore()

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

  
    