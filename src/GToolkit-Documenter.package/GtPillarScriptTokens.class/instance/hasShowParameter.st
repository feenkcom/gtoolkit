testing
hasShowParameter
	^ (self scriptParameters includesKey: self showParameterName) or: [ 
		self scriptParameters includesKey: self showLiveParameterName ]