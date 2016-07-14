Backbone = require 'backbone'
DateUtil = require '../util/date'

User = Backbone.Model.extend {
	defaults:
		userName: 'Anonymous'
		userEmail: 'user@mail.com'
		password: ''
		confirmPassword: ''
		siteUrl: 'example.com'
		userPhone: '555-555-555'
		userBirthday: new Date
		userGender: '1'
		userAbout: 'About me'
		userSkill: 0

	# Serealize to compare back-end format
	toJSON: ->
		attr = _.clone @attributes

		# birthday
		birthday = @attributes.userBirthday
		attr.userBirthday = {
			day: do birthday.getDate
			month: do birthday.getMonth
			year: do birthday.getFullYear
		}

		# password
		attr.password = {
			first: attr.password
			second: attr.confirmPassword
		}

		delete attr.confirmPassword

		return {user: attr}

	url: '/api/process-form'
}

module.exports = User