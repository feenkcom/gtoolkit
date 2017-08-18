scripting
connectTo: aToBlock
	^ self
		connectFrom: [ :each | each ] 
		to: aToBlock