#= require jquery
#= require jquery_ujs

#= require laconic
#= require lodash
#= require backbone-1.0.0
#= require leaflet

#= require sinon
#= require sinon-chai
#= require chai-changes
#= require chai-backbone
#= require chai-factories

#= require chai-jquery

#= require namespace


# set the Mocha test interface
# see http://visionmedia.github.com/mocha/#interfaces
#mocha.ui "bdd"

# ignore the following globals during leak detection
#mocha.globals ["YUI"]

# or, ignore all leaks
#mocha.ignoreLeaks()

# set slow test timeout in ms
mocha.timeout 2000

# Show stack trace on failing assertion.
chai.Assertion.includeStack = true

#beforeEach ->
#  window.page = $("#konacha")

