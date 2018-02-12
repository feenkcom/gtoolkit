server - basic
cdnUrl
	<gtExample>
	<label: 'Local Content Delivery Network URL'>
	| url |
	url := self restApiUrl / 'cdn'.
	^ url