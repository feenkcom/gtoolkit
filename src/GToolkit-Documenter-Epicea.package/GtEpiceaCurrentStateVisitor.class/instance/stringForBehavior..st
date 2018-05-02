visitor
stringForBehavior: aClassOrTrait
	^ theEnvironment
		at: aClassOrTrait name
		ifPresent: [ :existingBehavior | self stringForExistingBehavior: existingBehavior ]
		ifAbsent: [ '' ]