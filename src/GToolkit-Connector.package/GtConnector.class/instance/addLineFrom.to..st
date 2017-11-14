private - adding / removing
addLineFrom: aSourceElement to: aTargetElement
	"Add a line connecting two given elements.
	Both elements must not be nil"
	| aLineElement aDeleteListener |
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
		
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].
		
	self
		assert: [ (aSourceElement isConnectedTo: aTargetElement) not ]
		description: [ 'Source must not be connected to the target' ].
		
	self
		assert: [ (aTargetElement isConnectedTo: aSourceElement) not ]
		description: [ 'Target must not be connected to the source' ].

	self
		assert: [ aSourceElement ~~ aTargetElement ]
		description: [ 'Can not connect element with itself' ].

	self
		assert: [ self doesExist: aSourceElement ]
		description: [ 'Source element must be in the scene graph' ].
		
	self
		assert: [ self doesExist: aTargetElement ]
		description: [ 'Target element must be in the scene graph' ].

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
		aSourceElement beNotConnectedTo: aTargetElement.
		aTargetElement beNotConnectedTo: aSourceElement.
		aLineElement removeFromParent ].
	
	aSourceElement addEventHandler: aDeleteListener.
	aTargetElement addEventHandler: aDeleteListener.
	
	aSourceElement beConnectedTo: aTargetElement.
	aTargetElement beConnectedTo: aSourceElement.

	self addChild: aLineElement