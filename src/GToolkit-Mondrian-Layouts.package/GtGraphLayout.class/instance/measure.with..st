layout
measure: anElement with: anExtentSpec
	
	anElement childrenDo: [ :each |
		self
			measureChild: each
			parentSpec: anExtentSpec ].

	self applyOn: anElement managedChildren.
	self fit: anElement with: anExtentSpec