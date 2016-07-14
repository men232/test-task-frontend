Marionette = require 'backbone.marionette'
UtilDate = require '../util/date'

# View of profile edit form modal
ProfileEditView = Marionette.LayoutView.extend {
	initialize: (opts) ->
		@user = do opts.user.clone

	# Event to update user model by modifed input
	formChanged: (e) ->
		$input = $ e.currentTarget
		field = $input.data 'field'

		# Spec parse for date
		if field is 'userBirthday'
			value = $input[0].valueAsDate
		else
			value = do $input.val

		@user.set field, value

	# Method to save form with error displaying
	save: ->
		# Remove all errors
		do ($ '.msg-error').remove

		(do @user.save).done ->
			# close modal
			($ '#modal').trigger 'hidden'
		.fail (data) =>
			response = data.responseJSON

			if response.code isnt 400
				console.error 'internal error'
				return

			# Parse and display errors
			errors = @parseError response.errors.children
			@displayError errors

	# Method to display validation errors
	displayError: (errors) ->
		for k, v of errors
			$input = @$el.find "[data-field='#{k}']"
			$err = $input.find "#{k}-error-msg"

			if $err.length < 1
				$msg = $ "<div id='#{k}-error-msg' class='msg-error text-danger'>#{v}</div>"
				$msg.insertBefore $input
			else
				$err.html v

	# Method to parse errors to simple key value object
	parseError: (errors) ->
		list = {}

		for k, v of errors
			if v.errors? and v.errors.length > 0
				list[k] = v.errors.join '<br>'
			else if v.children
				list[k] = @joinChildrenError v.children

		return list

	# Method to transfrom inside children errors to simple string message
	joinChildrenError: (errors) ->
		result = ''

		for k, v of errors
			if v.errors? and v.errors.length > 0
				result += v.errors.join '<br>'
			else if v.children
				result += @joinChildrenError v.children

		return result;

	onShow: ->
		fields = @user.attributes

		for k, v of fields
			$el = @$el.find "[data-field='#{k}']"

			if v instanceof Date
				$el[0].valueAsDate = v
			else
				$el.val v

	ui:
		save: '.save'

	events:
		'click @ui.save': 'save'
		'change input': 'formChanged'
		'change select': 'formChanged'
		'change textarea': 'formChanged'

	template: require '../templates/profile.edit.tmpl.html'
}

# Export views
module.exports = ProfileEditView