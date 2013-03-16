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


#model.should.trigger("change", with: [model]).when ->
#model.set attribute: "value"

#config = _.extend(@m.config, @m.spec_config)
#mainRoute = new Router(config)
#
#describe "City#model", ->
#
#  it "Response should have property total_rows, 3", ->
#    deferred.done( (data) =>
#      expect(data).to.have.property('total_rows', 3)
#    )#