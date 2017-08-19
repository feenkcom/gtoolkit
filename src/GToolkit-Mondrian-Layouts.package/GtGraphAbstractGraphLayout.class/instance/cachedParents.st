private
cachedParents
	
	cachedParents ifNil: [cachedParents := IdentityDictionary new: 1000].
	^cachedParents