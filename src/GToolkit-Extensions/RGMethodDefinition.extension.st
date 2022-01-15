Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtBasicSourceFor: aView [
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem) asCoderViewModel expanded: true)
				asElement) ].
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Implementors';
		priority: 11;
		stencil: [ self selector gtImplementors ]
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView explicit
		title: 'Senders';
		priority: 10;
		stencil: [ self selector gtSenders ]
]

{ #category : #'*GToolkit-Extensions' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ 
			 ((GtPharoMethodCoder forMethod: self) 
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ].
]
