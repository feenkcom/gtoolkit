private-element
maySetHeightOfPreview: exampleElement
	self scriptParameters
		at: 'height'
		ifPresent:
			[ :aHeight | exampleElement previewHeight: (Number readFromString: aHeight) ]