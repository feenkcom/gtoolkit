Extension { #name : #TAsyncPromise }

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPromiseFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Promise';
		priority: 10;
		stencil: [
			BrFromPromise new
				matchParent;
				stencil: [
					BrHorizontalPane new
						matchParent;
						addAptitude: BrShadowAptitude new beLarge;
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter weight: 0.75.
							c frame vertical alignCenter weight: 0.75 ];
						addChild: (BrVerticalPane new
							hExact: 50;
							vMatchParent) as: #status;
						addChild: (BrVerticalPane new
							alignCenter;
							matchParent) as: #result ];
				dataBinder: [ :anElement :aData |
					| aResultElement aStatusElement |

					aStatusElement := anElement childWithId: #status.
					aResultElement := anElement childWithId: #result.
			
					aResultElement removeChildren.
					aData
						ifSuccess: [ :aValue |
							aStatusElement
								background: anElement theme status successBackgroundColor.
							aResultElement addChild: (GtInspector forObject: aValue) ]
						ifError: [ :anError |
							aStatusElement
								background: anElement theme status errorBackgroundColor.
							aResultElement
								addChild: anError asDebuggableElement ]
						ifPending: [
							aStatusElement
								background: anElement theme status neutralBackgroundColor.
							
							aResultElement
								addChild: (BrLabel new
									aptitude: (BrGlamorousLabelAptitude new foreground: Color lightGray);
									text: 'Waiting a promised value...') ] ];
				promise: self ]
]
