private - adding / removing
addLineFrom: aSourceElement to: aTargetElement
	"Add a line between two given elements.
	Both elements must not be nil"
	| aLineElement aDeleteListener |
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
		
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].

	aLineElement := BlLineElement new.
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
		wantsMouse: false;
		fromAnchor: (BlElementCenterAnchor element: aSourceElement);
		toAnchor: (BlElementLeftCenterAnchor element: aTargetElement).

	"Line should disappear when any of source or target elements is deleted"
	aDeleteListener := nil.
	"we should not forget to remove event handlers before removing a line"
	aDeleteListener := BlEventHandler on: BlElementRemovedEvent do: [ :anEvent |
		aSourceElement removeEventHandler: aDeleteListener.
		aTargetElement removeEventHandler: aDeleteListener.
		aLineElement removeFromParent ].
	
	aSourceElement addEventHandler: aDeleteListener.
	aTargetElement addEventHandler: aDeleteListener.

	self addChild: aLineElement