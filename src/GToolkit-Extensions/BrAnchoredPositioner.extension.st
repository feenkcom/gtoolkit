Extension { #name : #BrAnchoredPositioner }

{ #category : #'*GToolkit-Extensions' }
BrAnchoredPositioner >> gtBoundsFor: aView [
	<gtView>
	self target ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Bounds';
		priority: 1;
		stencil: [ | aContainer aSceneContainer anAnchorBounds anAnchorElement anExtent aPreferredBounds aPopupElement anExtentElement aExplanation |
			aContainer := BrVerticalPane new
					fitContent;
					margin: (BlInsets all: 10);
					clipChildren: false.

			aSceneContainer := BlElement new
					size: self target extent;
					border: (BlBorder paint: Color gray width: 1);
					clipChildren: false.

			anAnchorBounds := anchorBoundsInTarget
					ifNil: [ self computeAnchorBoundsInTarget ].

			anAnchorBounds
				ifNotNil: [ anAnchorElement := BrFrame new
							exact: anAnchorBounds extent;
							relocate: anAnchorBounds position;
							border: (BlBorder paint: Color orange width: 1).
					aSceneContainer addChild: anAnchorElement as: #anchor ].

			anExtent := extent ifNil: [ self target extent / 2 ].

			aPreferredBounds := popupPreferredMaxBoundsInTarget
					ifNil: [ (self computePopupPreferredMaxBoundsInTarget: anExtent) bounds ].

			aPreferredBounds
				ifNotNil: [ aPopupElement := BrFrame new
							exact: aPreferredBounds extent;
							relocate: aPreferredBounds position;
							border: (BlBorder builder
									paint: Color blue;
									width: 1;
									in: [ :theBuilder | popupPreferredMaxBoundsInTarget ifNil: [ theBuilder dashed ] ];
									build).
					aSceneContainer addChild: aPopupElement as: #popup.

					anExtentElement := BrFrame new
							exact: anExtent;
							relocate: aPreferredBounds position;
							border: (BlBorder builder
									paint: Color tan;
									width: 1;
									in: [ :theBuilder | popupPreferredMaxBoundsInTarget ifNil: [ theBuilder dashed ] ];
									build).
					aSceneContainer addChild: anExtentElement as: #extent ].

			aContainer addChild: aSceneContainer as: #scene.

			aExplanation := BrHorizontalPane new
					fitContent;
					addChild: (BrLabel new
							aptitude: BrGlamorousLabelAptitude;
							text: ('anchor bounds' asRopedText
									foreground: Color orange;
									append: (' and ' asRopedText foreground: Color lightGray);
									append: (popupPreferredMaxBoundsInTarget
											ifNil: [ 'an example of ' asRopedText italic ]
											ifNotNil: [ 'computed ' asRopedText ]);
									append: ('popup max bounds ' asRopedText foreground: Color blue);
									append: (' for an extent' asRopedText foreground: Color tan))).

			aContainer addChild: aExplanation as: #explanation.


			aContainer ]
]
