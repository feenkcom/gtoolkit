Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
BlockClosure >> gtRefersStronglyTo: anObject [
	^self receiver == anObject or: 
			[(1 to: self numCopiedValues)
				contains: [:anIndex | (self copiedValueAt: anIndex) == anObject]]
]
