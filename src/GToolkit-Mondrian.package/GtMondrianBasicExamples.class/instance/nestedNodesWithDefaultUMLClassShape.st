node creation
nestedNodesWithDefaultUMLClassShape
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withDefaultContainer ];
		with: (1 to: 10 ); 
		forEach: [:each | view nodes with: (1 to: 10) ].
	^ view