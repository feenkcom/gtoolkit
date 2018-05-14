testing
hasShowParameter
	^ (self scriptParameters includesKey: self showParameterName) or: [ 
			self shouldExpandPreview ]