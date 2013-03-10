# set the Mocha test interface
# see http://visionmedia.github.com/mocha/#interfaces
#mocha.ui "bdd"

# ignore the following globals during leak detection
#mocha.globals ["YUI"]

# or, ignore all leaks
#mocha.ignoreLeaks()

# set slow test timeout in ms
mocha.timeout 5000

# Show stack trace on failing assertion.
chai.Assertion.includeStack = true