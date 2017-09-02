scripting
connectToAll: aToBlock
	^ self
		connectFrom: [ :each | each ] 
		toAll: aToBlock