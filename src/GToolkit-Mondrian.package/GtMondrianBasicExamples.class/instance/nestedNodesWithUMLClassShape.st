node creation
nestedNodesWithUMLClassShape
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withContainers: #(one two) ];
		with: (1 to: 10 ); 
		forEach: [:each | view nodes with: (1 to: 10) ] in: #one;
		forEach: [:each | view nodes with: (1 to: 20) ] in: #two.
	^ view