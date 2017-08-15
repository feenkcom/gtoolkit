streaming
nextPutAll: aString with: aBlock
	| previewAttribute |
	aString do: [ :character | 
		self flag: 'change this once the editor is able to insert whole strings'.
		editor insertString: character asString at: text size ].
	editor moveCursorTo: text size.
	previewAttribute := BrTextExpandButtonAttribute new.
	previewAttribute action: [ :aBrText :aTextEditor :anAttribute |
		| isExpanded |
		isExpanded := anAttribute expanded.
		isExpanded
			ifTrue: [ aBrText clearAttributes: [ :aTextAttribute | aTextAttribute ~= previewAttribute ] ]
			ifFalse: [ aBrText attributes: { aBlock value } ].
		anAttribute expanded: isExpanded not.
		aTextEditor invalidateAll.
		aTextEditor updateAll ].
	text 
		attributes: { previewAttribute }
		from: text size - aString size + 1
		to: text size.
	editor invalidateAll; updateAll