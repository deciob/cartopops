#= require libs/data_strategy


@m.specDataStrategy = class specDataStrategy extends @m.dataStrategy

  # Passing a "fake response" as an argument to the constructor.
  # Note: this is different from app_data_strategy.
  constructor: (response) ->
    @response = JSON.parse(response)

  getDeferred: ->
    jQuery.Deferred()

  # Resolves the deferred immediately and fires the global event.
  # It is all a (fast) fake!
  onDeferredDone: (deferred, dispatcher) ->
    deferred.resolve(@response)
    dispatcher.trigger "dataStrategy#onDeferredDone", @response.rows