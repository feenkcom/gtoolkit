instance creation
inEnvironment: anEnvironment

	^ self basicNew 
		initializeWith: anEnvironment;
		yourself