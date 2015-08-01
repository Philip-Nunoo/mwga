Router.map ->
	@route 'home', 
    	path: "/"
	    loadingTemplate: 'loading'
	    layoutTemplate: 'homeLayout'
	    render: 'home'