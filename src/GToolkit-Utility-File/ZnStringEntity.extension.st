Extension { #name : #ZnStringEntity }

{ #category : #'*GToolkit-Utility-File' }
ZnStringEntity class >> gtPillar: string [
	^ (self type: GtFileUtility pillarMimeType)
		string: string;
		yourself
]
