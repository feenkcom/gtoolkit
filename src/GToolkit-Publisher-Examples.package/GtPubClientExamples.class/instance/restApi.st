server - basic
restApi
	<gtExample>
	<label: 'REST API object sending to the local server'>
	| restApi |
	restApi := GtPubRestApi new
		url: self restApiUrl;
		yourself.
	self assert: restApi url equals: self restApiUrl.
	^ restApi