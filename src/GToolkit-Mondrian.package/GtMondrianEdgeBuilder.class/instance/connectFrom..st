scripting
connectFrom: aFromBlock
	^ self
		connectFrom: aFromBlock 
		to: [ :each | each ]