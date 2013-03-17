# Inspired by the strategy pattern explained here:
# http://sokolmichael.com/posts/2013-03-08-strategy-design-pattern-in-javascript?utm_source=javascriptweekly&utm_medium=email

@m.dataStrategy = class dataStrategy

  getDeferred: ->
    throw new Error("dataStrategy#getDeferred needs to be overridden.")

  onDeferredDone: ->
    throw new Error("dataStrategy#onDeferredDone needs to be overridden.")
