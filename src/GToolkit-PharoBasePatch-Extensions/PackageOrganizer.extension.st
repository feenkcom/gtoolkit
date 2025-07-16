Extension { #name : #PackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
PackageOrganizer >> createPackageNamed: aString [
	<gtPharoPatch: #Pharo>
	
	^ self addPackage: aString 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
PackageOrganizer >> includesPackageNamed: aSymbol [
	<gtPharoPatch: #Pharo>
	"Takes a package or a package name as parameter and return true if I include this package."

	self packageNamed: aSymbol asSymbol ifAbsent: [ ^ false ].
	^ true 
]
