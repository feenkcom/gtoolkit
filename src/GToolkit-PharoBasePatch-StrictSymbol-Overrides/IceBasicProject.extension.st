Extension { #name : #IceBasicProject }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceBasicProject >> sourceDirectory [
	
	^ properties at: #srcDirectory ifAbsent: [ 'src' ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceBasicProject >> sourceDirectory: aString [ 
	
	properties at: #srcDirectory put: aString
]
