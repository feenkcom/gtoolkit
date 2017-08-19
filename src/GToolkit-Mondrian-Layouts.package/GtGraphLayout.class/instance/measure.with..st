layout
measure: anElement with: anExtentSpec
	
	anElement childrenDo: [ :each |
		self
			measureChild: each
			parentSpec: anExtentSpec.
		each position: each measuredBounds origin.
		each size: each measuredBounds extent ].

	self applyOn: anElement managedChildren.
	self fit: anElement with: anExtentSpec