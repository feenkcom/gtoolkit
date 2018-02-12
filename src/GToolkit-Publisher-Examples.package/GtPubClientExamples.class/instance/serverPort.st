server - basic
serverPort
	<gtExample>
	<label: 'REST API object sending to the local server'>
	| port |
	port := self basicServer port.
	port isZero ifTrue: [ port := self basicServer serverSocket port ].
	self assert: port > 0.
	^ port