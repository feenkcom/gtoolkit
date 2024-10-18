Extension { #name : #Bag }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Bag >> asGtStringContentSet [
	"Answer a set with the elements of the receiver."
	"#(1 2 2 3 1 1 1) asBag asSet >>> #(1 2 2 3 1 1 1) asSet"

	^ contents keys asGtStringContentSet
]
