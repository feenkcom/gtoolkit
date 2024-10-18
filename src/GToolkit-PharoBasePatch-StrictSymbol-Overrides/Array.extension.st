Extension { #name : #Array }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Array >> asGtStringContentSet [

	^ GtStringContentSet newFromArray: self
]
