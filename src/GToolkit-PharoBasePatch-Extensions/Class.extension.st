Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Class >> category: aString [
	<gtPharoPatch: #Pharo12>
	"Categorize the receiver under the system category, aString, removing it from
	any previous categorization."

	| converter |
	self category = aString ifTrue: [ ^ self ].
 
	converter := CategoryConverter category: aString asSymbol.

	^ self package: converter packageName tag: converter tagName
]
