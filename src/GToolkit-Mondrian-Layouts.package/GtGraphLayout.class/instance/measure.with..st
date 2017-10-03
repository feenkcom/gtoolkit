layout
measure: anElement with: anExtentSpec
	
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ].
	
	self measureIgnored: anElement with: anExtentSpec.

	self applyOn: anElement managedChildren .
	self fit: anElement with: anExtentSpec