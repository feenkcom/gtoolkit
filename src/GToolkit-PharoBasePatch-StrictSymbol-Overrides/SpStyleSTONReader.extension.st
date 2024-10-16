Extension { #name : #SpStyleSTONReader }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
SpStyleSTONReader >> lookupClass: name [
	"The SpStyleSTONReader only looks for ston names in the hierarchy of SpStyle"

	^ classes
		at: name
		ifAbsentPut: [ self styleClasses
				detect: [ :class | class isMeta not and: [ class stonName sameContentAs: name ] ]
				ifNone: [ NotFound signalFor: name ] ]
]
