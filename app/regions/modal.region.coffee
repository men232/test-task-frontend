Marionette = require 'backbone.marionette'
Bootstrap = require 'bootstrap'

ModalRegion = Marionette.Region.extend {
	initialize: ->
		region = @
		@$el.on 'hidden', (event) =>
			do region.destroy

	onShow: ->
		@$el.modal 'show'

	onDestroy: ->
		@$el.modal 'hide'
}

module.exports = ModalRegion