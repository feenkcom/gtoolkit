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

			eachElement = commonParent
				ifTrue: [ 
					eachPreviewElement addChild:
							(BlTextElement new text: 'Common parent' asRopedText)
								asScalableElement ]
				ifFalse: [ 
					eachElement = provisionalCommonParent
						ifTrue: [ 
							eachPreviewElement addChild:
									(BlTextElement new text:
											 'Potential common parent' asRopedText) asScalableElement ]
						ifFalse: [ 
							(elements includes: eachElement) ifTrue: [ 
									eachPreviewElement addChild:
											(BlTextElement new text: 'Node' asRopedText)
												asScalableElement ] ] ].

			eachPreviewElement enqueueTask: (BlTaskAction new action: [ 
							 | eachForm |
							 eachForm := eachElement asSpartaForm.
							 eachPreviewElement
								 background: eachForm;
								 size: eachForm extent ]) ];
		with: theNodes.
	aMondrian edges connectFrom: [ :x | x parent ].
	aMondrian layout tree levelDistance: 50; nodeDistance: 50.

	^ aMondrian
]
