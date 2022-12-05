Extension { #name : #GtSmaCCNodeStylerRule }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCNodeStylerRule >> gtStylerRulesViewDescriptionText [
	^ 'Node class name: ' asRopedText
		foreground: BrGlamorousColors disabledButtonTextColor;
		append: self nodeClassName asRopedText
]
