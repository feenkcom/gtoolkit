scripting
forEach: aBlock
	createdElements do: [ :child |	
		self mondrian 
			with: (GtMondrianStep new root: child) 
			do: [ aBlock value: child mondrianModel ] ].
	^ createdElements