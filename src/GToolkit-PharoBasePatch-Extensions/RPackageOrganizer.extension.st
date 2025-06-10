Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer >> includesPackageNamed: aSymbol [
	<gtPharoPatch: #Pharo>
	"Takes a package or a package name as parameter and return true if I include this package."

	self packageNamed: aSymbol asSymbol ifAbsent: [ ^ false ].
	^ true 
]
