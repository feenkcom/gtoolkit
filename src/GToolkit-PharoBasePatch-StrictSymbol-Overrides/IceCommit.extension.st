Extension { #name : #IceCommit }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceCommit >> includesPackageNamed: aName [
	"A commit names its packages with Strings (the directory names), the working copy and the image with Symbols: compare by content"
	<gtPharoPatch: #StrictComparison>
	| packageNames |
	packageNames := self packageNames.
	^ (packageNames includes: aName) or: [ packageNames includesSameContentAs: aName ]
]
