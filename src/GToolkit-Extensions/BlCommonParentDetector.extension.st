Extension { #name : #BlCommonParentDetector }

{ #category : #'*GToolkit-Extensions' }
BlCommonParentDetector >> gtTreeFor: aView [
	<gtView>

	^ aView mondrian
		title: 'Tree';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*GToolkit-Extensions' }
BlCommonParentDetector >> paintTreeWith: aMondrian [
	| theElements theNodes |
	theElements := elements copy.
	theNodes := OrderedCollection withAll: theElements.

	commonParent ifNotNil: [ :aCommonParent | 
		theElements do: [ :eachElement | 
			(eachElement hasParent: aCommonParent) ifTrue: [ 
				eachElement allParentsTo: aCommonParent do: [ :eachParent | 
					(theNodes includes: eachParent) ifFalse: [ 
						theNodes add: eachParent ] ] ] ] ].

	provisionalCommonParent ifNotNil: [ :aProvisionalCommonParent | 
		theElements do: [ :eachElement | 
			(eachElement hasParent: aProvisionalCommonParent) ifTrue: [ 
				eachElement
					allParentsTo: aProvisionalCommonParent
					do: [ :eachParent | 
						(theNodes includes: eachParent) ifFalse: [ 
							theNodes add: eachParent ] ] ] ] ].

	aMondrian nodes
		stencil: [ :eachElement | 
			| eachPreviewElement |

			eachPreviewElement := BlElement new.
			eachPreviewElement size: 10@10.
			eachPreviewElement geometry: BlCircleGeometry new.

			eachElement = commonParent
				ifTrue: [ eachPreviewElement background: BrGlamorousColors textHighlightColor ]
				ifFalse: [ 
					eachElement = provisionalCommonParent
						ifTrue: [
							eachPreviewElement
								background: (BlRadialGradientPaint new
									stops: { 
										0 -> Color white.
										1 -> BrGlamorousColors textHighlightColor };
									radius: 5;
									center: 5@5);
								border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 1) ]
						ifFalse: [
							(elements includes: eachElement)
								ifTrue: [ eachPreviewElement border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 1) ]
								ifFalse: [ eachPreviewElement border: (BlBorder paint: BrGlamorousColors lightBorderColor width: 1) ] ] ].
			eachPreviewElement ];
		with: theNodes.

	aMondrian edges 
		stencil: [
			BlSigmoidElement new
				beHorizontal;
				sharpness: 0.1;
				border: (BlBorder paint: (BrGlamorousColors defaultHeaderBackgroundColor alpha: 0.5) width: 2) ];
		fromRightCenter;
		toLeftCenter;
		connectFrom: #parent.

	aMondrian layout horizontalTree levelDistance: 30; nodeDistance: 10..

	^ aMondrian
]
