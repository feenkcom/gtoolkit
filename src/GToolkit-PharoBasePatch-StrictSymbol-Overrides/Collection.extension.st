Extension { #name : #Collection }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
Collection >> asGtStringContentSet [
	"Answer a GtStringContentSet whose elements are the unique elements of the receiver."

	"{1. 2} asSet =    {2. 1} asSet >>> true"
	"{1. 2} asSet = {1. 2. 2} asSet >>> true"
	"{1. 2} asSet = {1. 2. 3} asSet >>> false"
	"{} asSet = Set new >>> true"

	^ GtStringContentSet withAll: self
]
