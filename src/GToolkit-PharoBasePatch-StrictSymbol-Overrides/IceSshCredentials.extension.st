Extension { #name : #IceSshCredentials }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceSshCredentials >> isDefault [

	^ host = '*'
]
