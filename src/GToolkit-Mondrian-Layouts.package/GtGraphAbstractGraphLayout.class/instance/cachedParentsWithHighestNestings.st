private
cachedParentsWithHighestNestings
	
	cachedParentsWithHighestNestings
		ifNil: [cachedParentsWithHighestNestings := IdentityDictionary new: 1000].
	^cachedParentsWithHighestNestings