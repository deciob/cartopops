#= require spec_helper
#= require spec_config
#= require config
#= require app/router


config = _.extend(@m.config, @m.spec_config)
mainRoute = new Router(config)

# TODO: simulate failure
# http://www.jonnyreeves.co.uk/2012/unit-testing-async-javascript-with-promises-and-stubs/

describe "Router#Request#Cities", ->

  # Alternative approach:
  #sinon.stub(mainRoute, 'get_deferred').returns(
  #  jQuery.Deferred().resolve(config.fake_city_response) )
  #deferred = mainRoute.get_deferred(mainRoute.get_sql())

  #deferred = mainRoute.getDeferred( mainRoute.get_sql() )

  it "Response should have property total_rows, 3", ->
    mainRoute.deferred.done( (data) =>
      expect(data).to.have.property('total_rows', 3)
    )

  it "Response has time", ->
    mainRoute.deferred.done( (data) =>
      expect(data.time).to.be.a('number')
    )

  it "Response has rows", ->
    mainRoute.deferred.done( (data) =>
      expect(data.rows).to.be.a('array')
    )

  it "Response has the correct fields", ->
    mainRoute.deferred.done( (data) =>
      response_fields = _.map(data.rows[0], (val, key) -> key).join(",")
      config_fields = config.cartodb_sql_fields
      expect(response_fields).to.equal(config_fields)
    )


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

  



      
