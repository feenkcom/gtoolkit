accessing
affect: aBrText in: aBrEditor
	| scalableElement imageElement |
	
	scalableElement := BlScalableElement new.
	
	scalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c textFlow pushLine.
		c vertical fitContent ].
	
	imageElement := BlElement new
		size: self image extent;
		background: (BlBackground builder image: self image; build);
		yourself.
		
	scalableElement contentElement: imageElement.
	
	^ scalableElement