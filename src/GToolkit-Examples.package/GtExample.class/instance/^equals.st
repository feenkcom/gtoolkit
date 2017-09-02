testing
= anExample
	^ self class = anExample class 
		and: [ self methodClass = anExample methodClass 
			and: [ self selector = anExample selector ] ]