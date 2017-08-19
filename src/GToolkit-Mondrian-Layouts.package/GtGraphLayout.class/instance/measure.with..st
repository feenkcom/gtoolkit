layout
measure: anElement with: anExtentSpec
	
	anElement childrenDo: [ :each |
		self
			measureChild: each
			parentSpec: anExtentSpec.
		each extent: each measuredExtent ].

	self applyOn: anElement managedChildren.
	self fit: anElement with: anExtentSpec