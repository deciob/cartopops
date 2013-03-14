#= require sinon
#= require chai-changes
#= require chai-backbone
#= require chai-factories

#= require ../spec_helper
#= require lodash
#= require backbone
#= require ../../../app/assets/javascripts/app/router
#= require cartodb
#= require config
#= require ../spec_config


config = _.extend(@config, @spec_config)
mainRoute = new Router(config)

#describe "Router#Request#Cities", ->
#
#  # Use Sinon to replace jQuery's ajax method with a spy.
#  #beforeEach ->
#  #  sinon.spy $, "ajax"
#  s = no
#  beforeEach ->
#    s = sinon.stub($, "ajax")#.yieldsTo "success", config.fake_city_response
#  
#
#
#  # Restor jQuery's ajax method to its original state
#  afterEach ->
#    $.ajax.restore()
#
#  it "should make an ajax call", (done) ->
#    deferred = mainRoute.get_deferred(mainRoute.get_sql())
#    s.yieldsTo "complete", config.fake_city_response
#
#    console.log deferred, mainRoute.get_deferred
#
#    #deferred.success( (data) -> 
#    #  assertEquals(config.fake_city_response, data)
#    #)
#    #expect($.ajax.calledOnce).to.be.true;
#    done(); # let Mocha know we're done async testing


# TODO: simulate failure
# http://www.jonnyreeves.co.uk/2012/unit-testing-async-javascript-with-promises-and-stubs/

describe "Router#Request#Cities", ->

  sinon.stub(mainRoute, 'get_deferred').returns(
    jQuery.Deferred().resolve(config.fake_city_response) )
  deferred = mainRoute.get_deferred(mainRoute.get_sql())

  it "Response should have property total_rows, 3", ->
    deferred.done( (data) =>
      expect(JSON.parse(data)).to.have.property('total_rows', 3)
    )

  it "Response has time", ->
    deferred.done( (data) =>
      expect(JSON.parse(data).time).to.be.a('number')
    )

  it "Response has rows", ->
    deferred.done( (data) =>
      expect(JSON.parse(data).rows).to.be.a('array')
    )

  it "Response has the correct fields", ->
    deferred.done( (data) =>
      response_fields = _.map(JSON.parse(data).rows[0], (val, key) -> key).join(",")
      config_fields = config.cartodb_sql_fields
      expect(response_fields).to.equal(config_fields)
    )





#describe "Router#deferred", ->
#  
#  carto = mainRoute.get_carto()
#  stub = sinon.stub(carto, "execute", fake_req)
#  deferred = mainRoute.get_deferred(carto)
#  d = no
#  
#  it "has data", (done) ->
#    deferred.done( (data) =>
#      d = data
#      done()
#    )
#
#  describe "Router#deferred#done", ->
#
#    it "has time", (done) ->
#      expect(d.time).to.be.a('number')
#      done()
#    
#    it "has total_rows", (done) ->
#      expect(d.total_rows).to.be.a('number')
#      done()
#    
#    it "has rows", (done) ->
#      expect(d.rows).to.be.a('array')
#      done()
#
#    it "has the correct fields", (done) ->
#      response_fields = _.map(d.rows[0], (val, key) -> key).join(",")
#      config_fields = config.cartodb_sql_fields
#      expect(response_fields).to.equal(config_fields)
#      done()


# mainRoute.dispatcher gets overrided every time so the different tests
# do not interfere with each other.
describe "Router#routes", ->

  it "has changed country", (done) ->
    mainRoute.dispatcher = _.clone(Backbone.Events)
    mainRoute.dispatcher.on "Router:country_code", (country_code) ->
      expect(country_code).to.equal("BR")
      expect(mainRoute.old_year).to.equal(config.default_year)
      done()
    mainRoute.country "BR"

  it "has changed year", (done) ->
    mainRoute.dispatcher = _.clone(Backbone.Events)
    mainRoute.dispatcher.on "Router:year", (year) ->
      expect(year).to.equal(1955)
      done()
    mainRoute.country "BR", 1955

  it "has changed country and year", (done) ->
    mainRoute.dispatcher = _.clone(Backbone.Events)
    mainRoute.dispatcher.on "Router:country_code", (country_code) ->
      expect(country_code).to.equal("CN")
      done()
    mainRoute.dispatcher.on "Router:year", (year) ->
      expect(year).to.equal(2000)
      done()
    mainRoute.country "CN", 2000

  it "should correctly route", ->
    "country/CN/1955/".should
      .route.to mainRoute, "country", arguments: ["CN", "1955"]
    "countries/CN/1955/".should.not.route.to mainRoute, "country"
    "country/CN/".should.route.to mainRoute, "country"
    "country/world/".should.route.to mainRoute, "country"
    #"country/bonbon/".should.not.route.to mainRoute, "country"

  #it "should update old year", ->
  #  #mainRoute.dispatcher = _.clone(Backbone.Events)
  #  expect(-> mainRoute.old_country_code).to.change.when -> 
  #    mainRoute.country "BR", 2005

  



      
