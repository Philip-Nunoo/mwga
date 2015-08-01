@Rates = new Meteor.Collection "rates"

Schemas.Rates = new SimpleSchema
	data:
		type: Object
		blackbox: true
		
	createdAt:
		type: Date
		autoValue: ->
			new Date() if @isInsert

Rates.attachSchema Schemas.Rates