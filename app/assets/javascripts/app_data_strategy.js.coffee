#= require ./namespace
#= require ./libs/data_strategy

@m.appDataStrategy = class appDataStrategy extends @m.dataStrategy

  getDeferred: (sql, user, service) ->
    service ?= ".cartodb.com/api/v2/sql/?q="
    url = "http://" + user + service + sql
    deferred = $.ajax
      dataType: "json"
      url: url

  onDeferredDone: (deferred, dispatcher) ->
    deferred.done( (data) =>
      dispatcher.trigger "dataStrategy#onDeferredDone", data.rows
    ).error (error) ->
      console.log error