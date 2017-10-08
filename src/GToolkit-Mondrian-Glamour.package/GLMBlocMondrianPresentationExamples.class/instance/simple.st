public
simple
	<gtExample>
	| composite |
	composite := GLMCompositePresentation new.
	composite blocMondrian
		painting: [ :view :col | view nodes with: col ].
	^ composite startOn: (1 to: 100)