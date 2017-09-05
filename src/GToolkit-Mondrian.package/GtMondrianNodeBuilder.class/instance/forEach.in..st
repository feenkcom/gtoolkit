scripting
forEach: aBlock in: aSymbol
	createdElements do: [ :child |	
		self mondrian 
			with: (GtMondrianStep new root: (child mondrianChildrenContainerNamed: aSymbol)) 
			do: [ aBlock value: child mondrianModel ] ].
	^ createdElements