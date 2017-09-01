accessing-dynamic
dependenciesOrArguments
	| exampleMethod selfMessages |
	exampleMethod := self method.
	selfMessages := exampleMethod messages select: [ :aMessagename | 
		exampleMethod methodClass canPerform: aMessagename ].
	
	^ (((selfMessages 
		collect: [ :aMessagename | 
			(exampleMethod methodClass lookupSelector: aMessagename) ])
		select: [ :aMethod | aMethod isGtExampleMethod ])
		collect: [ :aMethod | aMethod gtExample ]) asOrderedCollection