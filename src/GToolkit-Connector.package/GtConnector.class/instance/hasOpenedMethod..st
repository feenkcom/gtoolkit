testing
hasOpenedMethod: aMethod
	"Return true if there already exists an editor opened on a given method, false otheriwse.
	aMethod must not be nil"
	<return: #Boolean>

	self elementWithMethod: aMethod ifPresent: [ ^ true ].
	^ false