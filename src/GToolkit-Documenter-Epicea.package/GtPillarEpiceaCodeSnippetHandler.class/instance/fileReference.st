accessing - parameters
fileReference
	^ self scriptParameters 
		at: self class epiceaParameterName
		ifPresent: [ :fileName | 
			GtFileUtility fileReferenceOfFileName: fileName relativeTo: self sourceDirectory  ]
		ifAbsent: [ nil ]