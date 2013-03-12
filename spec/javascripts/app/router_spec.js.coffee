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




describe "Router#requests", ->

  it "has requested", (done) ->

    server = sinon.fakeServer.create()
    #server.respondWith( [
    #  200, 
    #  { "Content-Type": "application/json" },
    #  config.fake_city_response
    #] )

    this.server.respondWith("GET", "http://deciob.cartodb.com/api/v2/sql?q=select%20cartodb_id%2Ccontinent%2Ccountry%2Ciso_a2%2Clatitude%2Clongitude%2Cpop1950%2Cpop1955%2Cpop1960%2Cpop1965%2Cpop1970%2Cpop1975%2Cpop1980%2Cpop1985%2Cpop1990%2Cpop1995%2Cpop2000%2Cpop2005%2Cpop2010%2Cpop2015%2Cpop2020%2Cpop2025%2Cregion_un%2Cregion_wb%2Csubregion%2Curban_aggl%20from%20urban_agglomerations",
      [200, { "Content-Type": "application/json" },
      '[{ "id": 12, "comment": "Hey there" }]'])

    #server.respondWith "GET", 
    #  "http://deciob.cartodb.com/api/v2/sql?q=select%20cartodb_id%2Ccontinent%2Ccountry%2Ciso_a2%2Clatitude%2Clongitude%2Cpop1950%2Cpop1955%2Cpop1960%2Cpop1965%2Cpop1970%2Cpop1975%2Cpop1980%2Cpop1985%2Cpop1990%2Cpop1995%2Cpop2000%2Cpop2005%2Cpop2010%2Cpop2015%2Cpop2020%2Cpop2025%2Cregion_un%2Cregion_wb%2Csubregion%2Curban_aggl%20from%20urban_agglomerations", 
    #  [200,
    #  "Content-Type": "application/json"
    #  , config.fake_city_response]
  
    sql = mainRoute.get_carto()
    #stub = sinon.stub(sql, "execute")
    callback = sinon.spy()
    
    deferred = sql.execute("select #{config.fields_str} from urban_agglomerations", 
      callback)
  
    server.respond()
    sinon.assert.called callback
    done()



#describe "Router#deferred", ->
#
#  deferred = mainRoute.get_deferred()
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

  



      
