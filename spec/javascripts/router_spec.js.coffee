#= require spec_helper
#= require lodash
#= require backbone
#= require router
#= require cartodb
#= require config

opts = 
  test: no
  config: config
  dispatcher: _.clone(Backbone.Events)

mainRoute = new Router(opts)

describe "Router#deferred", ->

  deferred = mainRoute.get_deferred()
  d = no
  
  it "has data", (done) ->
    deferred.done( (data) =>
      d = data
      done()
    )

  describe "Router#deferred#done", ->

    it "has time", (done) ->
      expect(d.time).to.be.a('number')
      done()
    
    it "has total_rows", (done) ->
      expect(d.total_rows).to.be.a('number')
      done()
    
    it "has rows", (done) ->
      expect(d.rows).to.be.a('array')
      done()

    it "has the correct fields", (done) ->
      response_fields = _.map(d.rows[0], (val, key) -> key).join(",")
      config_fields = config.cartodb_sql_fields
      expect(response_fields).to.equal(config_fields)
      done()


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

      
