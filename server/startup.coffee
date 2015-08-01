Meteor.startup ->
	# if Commodities.find().fetch() <= 0
		# console.log config.commodities

	if Rates.find().fetch() <=0
		console.log "no rates found"
		Meteor.call "exchanges", (error, resp)->
			console.log resp

			doc = 
				data: resp
				
			Rates.insert doc, (err, resp)->
				if err
					console.log "something went wrong: #{err}"				