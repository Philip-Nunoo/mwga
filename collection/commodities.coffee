@Commodities = new Meteor.Collection "commodities"

Schemas.Commodities = new SimpleSchema
	name:
		type: String
		label: 'Name'

	endPoint:
		type: String
		label: "End point"

Commodities.attachSchema Schemas.Commodities
