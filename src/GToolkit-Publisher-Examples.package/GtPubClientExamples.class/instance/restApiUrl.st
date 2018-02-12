server - basic
restApiUrl
	<gtExample>
	<label: 'REST API URL to the local server'>
	| url |
	url := ZnUrl new
		scheme: #http;
		host: NetNameResolver loopBackName;
		port: self serverPort;
		yourself.
	^ url