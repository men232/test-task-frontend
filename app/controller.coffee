Marionette = require 'backbone.marionette'
LayoutView = require './views/layout'
ExampleView = require './views/example'
ProfileView = require './views/profile.view'
UserModel = require './models/user.model'

Controller = Marionette.Object.extend {
	initialize: ->
		layout = new LayoutView

		@options.layout = layout;
		@options.regionManager = new Marionette.RegionManager {
			regions:
				main: '#app-hook'
		}

		@getOption 'regionManager'
			.get 'main'
			.show layout

	# Dislplay example view
	lading: ->
		view = new ExampleView
		@options.layout.showChildView 'content', view

	# Dislplay profile information page
	showProfile: () ->
		user = new UserModel
		view = new ProfileView {user: user}

		@options.layout.showChildView 'content', view

}

module.exports = Controller