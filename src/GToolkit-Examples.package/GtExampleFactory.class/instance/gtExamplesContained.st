public
gtExamplesContained
	| examples |
	examples := OrderedCollection new.
	self examplesDo: [ :example | examples add: example ].
	^ examples