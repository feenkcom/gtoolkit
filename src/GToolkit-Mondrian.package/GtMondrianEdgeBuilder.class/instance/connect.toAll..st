scripting
connect: aCollection toAll: aToBlock
	^ self
		connect: aCollection
		from: [ :each | each ] 
		toAll: aToBlock