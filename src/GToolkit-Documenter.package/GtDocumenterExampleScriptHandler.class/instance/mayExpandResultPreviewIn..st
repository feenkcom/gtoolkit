private-element
mayExpandResultPreviewIn: exampleElement
	self scriptParameters
		at: 'expandedPreview'
		ifPresent: [ :isExpandedPreview | 
			isExpandedPreview asLowercase = 'true'
				ifTrue: [ exampleElement showPreview ] ]