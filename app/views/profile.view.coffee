Marionette = require 'backbone.marionette'
ModalRegion = require '../regions/modal.region'
ProfileEditView = require './profile.edit.view'
DateUtil = require '../util/date'

# View of profile information
ProfileView = Marionette.ItemView.extend {
	initialize: (opts) ->
		@user = opts.user

	templateHelpers: () ->
		d = @user.get 'userBirthday'

		return {
			user: @user.attributes
			formatedBirthday: DateUtil.serealize d
		}

	showEditModal: () ->
		modal = new ModalRegion {el:'#modal'}
		view = new ProfileEditView {user: @user}

		modal.show view

	ui:
		edit: '.profile-edit'

	events:
		'click @ui.edit': 'showEditModal'

	template: require '../templates/profile.tmpl.html'
}

# Export views
module.exports = ProfileView