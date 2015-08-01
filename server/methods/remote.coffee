Future = Npm.require('fibers/future')

Meteor.methods
	QuandiData: (commodity) ->

		url = "https://www.quandl.com/api/v1/datasets/#{commodity}"

		quandiDataFuture = new Future()

		HTTP.get url, (error, result)->
			if error
				console.log "Error retrieving data"
				quandiDataFuture.throw new Meteor.Error 404, error
			else
				quandiDataFuture.return result.data

		quandiDataFuture.wait()

	exchanges: () ->

		url = "https://openexchangerates.org/api/latest.json?app_id=21379e69bdb74185af641f49d3e59b75"

		exchangesFuture = new Future()

		HTTP.get url, (error, result)->
			if error
				console.log error
				exchangesFuture.throw new Meteor.Error 404, error 
			else
				exchangesFuture.return result.data
		exchangesFuture.wait()

	exchangeAt: ()->