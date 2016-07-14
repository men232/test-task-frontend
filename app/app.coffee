Marionette = require 'backbone.marionette'
Router = require './router'

app = new Marionette.Application

app.on 'before:start', ->
	router = new Router pushState: true

	if Backbone.history
		do Backbone.history.start

module.exports = app