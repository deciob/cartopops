#= require spec_helper
#= require spec_config
#= require config
#= require app/router


config = _.extend(@m.config, @m.spec_config)
mainRoute = new Router(config)
Backbone.history.start()

# TODO: simulate failure
# http://www.jonnyreeves.co.uk/2012/unit-testing-async-javascript-with-promises-and-stubs/

describe "Router#Request#Data", ->

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


describe "Router#routes", ->

  # mainRoute.dispatcher gets overridden every time so the different 
  # tests do not interfere with each other.
  beforeEach -> 
    mainRoute.dispatcher = no
    mainRoute.dispatcher = _.clone(Backbone.Events)

  it "country should trigger Router:country_code with correct argument",
  (done) -> 
    mainRoute.dispatcher.on "Router:country_code", (country_code) ->
      country_code.should.equal "BR"
      done()
    mainRoute.navigate "country/BR/", {trigger: true}

  it "country should trigger Router:country_code with correct argument", 
  (done) -> 
    mainRoute.dispatcher.on "Router:country_code", (country_code) ->
      country_code.should.not.equal "XX"
      done()
    # Note: not calling 'BR' again, because this would 
    # no longer trigger a navigation event because of:
    # `if country_code != @prev_country_code`
    mainRoute.navigate "country/CN/", {trigger: true}

  it "country should trigger Router:country_code with correct argument",
  (done) -> 
    mainRoute.dispatcher.on "Router:year", (country_code) ->
      country_code.should.equal "1985"
      done()
    mainRoute.navigate "country/BR/year/1985/", {trigger: true}

  # Navigate has just been called with 1985 and this should 
  # not re-trigger a Router:country_code event
  it "country should not trigger Router:country_code with correct argument",
  (done) -> 
    mainRoute.dispatcher.on "Router:year", (country_code) ->
      # Expect failure if you get here!
      country_code.should.equal ""
      done()
    mainRoute.navigate "country/BR/year/1985/", {trigger: true}
    done()

  # Argument mismatch, this will not work!
  #it "country should trigger Router:year with correct argument",
  #(done) -> 
  #  mainRoute.dispatcher.on "Router:year", (country_code) ->
  #    country_code.should.equal 1975
  #    done()
  #  mainRoute.navigate "year/1975/", {trigger: true}

  it "country should trigger Router:year with correct argument",
  (done) -> 
    mainRoute.dispatcher.on "Router:year", (country_code) ->
      country_code.should.equal "1975"
      done()
    mainRoute.navigate "country/BR/year/1975/", {trigger: true}

  it "prev_year should update", ->
    prev_year = mainRoute.prev_year #"1975"
    mainRoute.navigate "country/BR/year/1965/", {trigger: true}
    mainRoute.prev_year.should.not.equal prev_year

  it "prev_country_code should update", ->
    prev_country_code = mainRoute.prev_country_code #"BR"
    mainRoute.navigate "country/IT/year/1965/", {trigger: true}
    mainRoute.prev_country_code.should.not.equal prev_country_code

  #  #mainRoute.dispatcher = _.clone(Backbone.Events)
  #  expect(-> mainRoute.prev_country_code).to.change.when -> 
  #    mainRoute.country "BR", 2005

  it "should correctly route", ->
    "".should.route.to mainRoute, "country"
    "country/CN/year/1955/".should
      .route.to mainRoute, "country", arguments: ["CN", "1955"]
    "countries/CN/year/1955/".should.not.route.to mainRoute, "country"
    "country/CN/".should.route.to mainRoute, "country"
    "country/world/".should.route.to mainRoute, "country"
    "country/bonbon/".should.route.to mainRoute, "country"  # Not ideal!
    #"year/1975/".should.route.to mainRoute, "country"  # Will not work!

  

  



      
