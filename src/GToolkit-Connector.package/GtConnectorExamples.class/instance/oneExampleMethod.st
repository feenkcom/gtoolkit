examples
oneExampleMethod
	<gtExample>
	| connector |
	connector := GtConnector new.
	connector addMethod: (BlFrameLayoutExamples>>#example).
	^ connector