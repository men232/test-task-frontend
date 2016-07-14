Marionette = require 'backbone.marionette'
Controller = require './controller'
Router = Marionette.AppRouter.extend {
	controller: new Controller
	appRoutes:
		'': 'lading'
		'profile': 'showProfile'
	}

module.exports = Router;