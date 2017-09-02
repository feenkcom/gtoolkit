scripting
connectFromAll: aFromBlock
	^ self
		connectFromAll: aFromBlock 
		to: [ :each | each ]