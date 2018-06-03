accessing
affect: aBrText in: anEditorElement
	| scalableElement imageElement resizer container |

	container := BlElement new.

	scalableElement := BlPannableElement new.

	scalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	imageElement := BlElement new
		size: self image extent;
		background: (BlBackground builder image: self image; build);
		yourself.
		
	scalableElement contentElement: imageElement.

	resizer := BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: container; minimumExtent: 0@75).

	container 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c textFlow pushLine.
			c vertical exact: 300  ];
		addChild: scalableElement; 
		addChild: resizer.
	 ^ container