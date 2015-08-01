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