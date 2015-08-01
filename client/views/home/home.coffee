plotPieChart = (option, div)->
	console.log 'l'
	seriesData = option

	# options.forEach (option)->
	# 	dataPoint = [option.name, option.votes];
	# 	seriesData.push(dataPoint)

	chartOptions = {
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: "pie",
			renderTo: "visualisation"
		},

		series: [{
			type: 'pie',
			name: 'Lunch Options',
			data: seriesData
		}]
	}

	chart = new Highcharts.Chart(chartOptions);

plotLineGraph = (data, div, options)->
	chartOptions = 
		chart:
			# plotBackgroundColor: null
			# plotBorderWidth: null
			# plotShadow: false
			renderTo: div		

		xAxis:
			type: 'datetime',
			maxZoom: 48 * 3600 * 1000,
			tickInterval:24*3600*1000*30*4

		rangeSelector:
			selected: 1

		title: 
			text: options.title

		# plotLines: options.plotLines

		series: [
			name: "New series"
			data: data
			type: 'areaspline'
			marker:
				enabled: true
				radius: 3
			shadow: true
			tooltip: valueDecimals: 2
			lineWidth: 1
			# pointInterval: 24 * 3600 * 1000 * 256
			fillColor:
				linearGradient:
					x1: 0
					y1: 0
					x2: 0
					y2: 1
				stops: [
					[
						0
						Highcharts.getOptions().colors[0]
					]
					[
						1
						Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')
					]
				]

		]

	chart = new Highcharts.Chart(chartOptions);visualisation

Template.home.events
	'click #category': (e, t) ->
		# console.log e.target.value
		$(".loading").show()
		$("#source").hide()
		Meteor.call 'QuandiData', e.target.value, (error, resp)->
			$("#source .source-name span").text resp.source_name
			$("#source .name span").text resp.name
			$("#source .description span").text resp.description
			$("#source .from-date span").text resp.from_date
			$("#source .to-date span").text resp.to_date

			# console.log resp
			$("#source").show()
			$(".loading").hide()

			data = []

			_.each resp.data, (item)->
				date = new Date item[0]
				year = date.getFullYear()
				month = date.getMonth()
				date = date.getDate()

				string = Date.UTC(year, month, date)
				data.push [string, item[1]]

			console.log data[0]

			options = 
				title: resp.source_name

			data = _.sortBy data, (name)->
				return name
			.reverse()

			plotLineGraph data, "visualisation", options


Template.home.helpers
	commodities:  ->
		config.commodities
	rates: ->
		# ratesRates.findOne()
		

Template.home.rendered = ->
	# rates.da
	Meteor.call 'exchanges', (error, data)->
		$(".exchanges .disclaimer").text data.disclaimer
		$(".exchanges .base").text data.base
		$(".exchanges .rates").text data.rates

		$(".exchanges .ghs").text data.rates.GHS
		$(".exchanges .gbp").text data.rates.GBP
		$(".exchanges .usd").text data.rates.USD

		console.log data.rates
		doc = 
			data: data
			
		Rates.insert doc, (err, resp)->
			if err
				console.log "something went wrong: #{err}"		