Extension { #name : #BlSpace }

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withSceneDriller [
	self root addEventFilter: GtSceneDrillerEventHandler new
]

{ #category : #'*GToolkit-SceneDriller' }
BlSpace >> withScreenshotHandler [
	self root
		addShortcut: (BlShortcutWithAction new
				name: 'Take screenshot';
				repeatable: false;
				combination: BlKeyCombination primaryShiftP;
				action: [ self root dispatchEvent: GtTakePicture new ]).
	self root
		when: GtTakePicture
		do: [ :anEvent | 
			| fileReference |
			anEvent consumed: true.
			fileReference := self root exportAsPNG.
			Clipboard clipboardText: fileReference fullName ]
]
