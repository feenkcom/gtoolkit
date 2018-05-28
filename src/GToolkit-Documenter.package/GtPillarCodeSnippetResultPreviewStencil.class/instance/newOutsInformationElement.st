instance creation
newOutsInformationElement
	| anElement aText |

	anElement := BlTextElement new.

	aText := ('(outs at: ' , self codeSnippet index asString , ')') asRopedText.
	aText attributes: { 
		self codeSnippet isException
			ifTrue: [ BrTextForegroundAttribute paint: Color red ]
			ifFalse: [ BrTextForegroundAttribute paint: Color gray ].
		BrFontGenericFamilyAttribute monospace }.
	
	anElement text: aText.
	
	^ anElement