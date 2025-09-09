Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer class >> default [
	"WARNING: Since this component can be changed (i.e. for testing) you should NOT use it directly.
	  Use RPackage class>>#organizer instead"

	^ self 
		forPharo12: [
			self class packageOrganizer ] 
		forPharo11AndPharo10: [
		 	default ifNil: [  default := self new ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer >> hasPackage: aPackage [
	<gtPharoPatch: #Pharo12>
	"Takes a package or a package name as parameter and return true if I include this package."

	^ aPackage isString
		  ifTrue: [
			  self packageNamed: aPackage asSymbol ifAbsent: [ ^ false ].
			  ^ true ]
		  ifFalse: [ self packages includes: aPackage ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RPackageOrganizer >> packageNamed: aSymbol ifPresent: aPresentBlock [
	^ packages
		at: aSymbol asSymbol
		ifPresent: aPresentBlock
]
