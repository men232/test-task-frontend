module.exports.serealize = (d) ->
	return [
		do d.getDate,
		do d.getMonth + 1,
		do d.getFullYear
	].join '/'

module.exports.parse = (s) ->
	return new Date s