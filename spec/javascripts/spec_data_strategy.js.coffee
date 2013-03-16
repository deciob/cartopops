#= require jquery

#= require ../../app/assets/javascripts/namespace
#= require ../../app/assets/javascripts/libs/data_strategy


@m.specDataStrategy = class specDataStrategy extends @m.dataStrategy

  constructor: (@response) ->
  #  super @dispatcher

  # The deferred is resolved immediately.
  getDeferred: ->
    jQuery.Deferred()#.resolve(@response)

  # Do nothing, the deferred is already resolved.
  onDeferredDone: (deferred, dispatcher) ->
    deferred.resolve(@response)
    dispatcher.trigger "dataStrategy#onDeferredDone", @response.rows