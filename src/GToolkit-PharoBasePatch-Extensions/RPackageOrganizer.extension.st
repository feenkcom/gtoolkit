Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer >> createPackageNamed: aString [
	<gtPharoPatch: #Pharo>
	
	^ self
		forPharo12: [ self addPackage: aString ]
		forPharo11AndPharo10: [ | instance |
			self validatePackageDoesNotExist: aString.

			instance := self packageClass named: aString.
			self registerPackage: instance.
			instance ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer >> includesPackageNamed: aSymbol [
	<gtPharoPatch: #Pharo>
	"Takes a package or a package name as parameter and return true if I include this package."

	self packageNamed: aSymbol asSymbol ifAbsent: [ ^ false ].
	^ true 
]
