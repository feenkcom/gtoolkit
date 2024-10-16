Extension { #name : #IceCommit }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceCommit >> includesPackageNamed: aName [
	
	^ self packageNames includes: aName asString
]
