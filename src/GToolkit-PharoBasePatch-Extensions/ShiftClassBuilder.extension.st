Extension { #name : #ShiftClassBuilder }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ShiftClassBuilder >> category: aString [
	<gtPharoPatch: #Pharo12>
	
	self 
		forPharo12: [
			| converter |
			converter := CategoryConverter 
				category: aString environment: self installingEnvironment.
			self package: converter packageName.
			self tag: converter tagName] 
		forPharo11AndPharo10: [ category := aString ]
]
