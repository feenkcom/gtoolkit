Extension { #name : #Array }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Array >> asGtStringContentSet [

	^ GtStringContentSet newFromArray: self
]
