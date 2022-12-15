Extension { #name : #BlElement }

{ #category : #'*GToolkit-Extensions' }
BlElement >> gtChildrenShortcutsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Children Shortcuts' translated;
		priority: 11;
		items: [ | all |
			all := OrderedCollection new.
			self allChildrenBreadthFirstDo: [ :each | all addAll: (each shortcuts collect: [:s | each -> s]) ].
			all ];
		column: 'Name'
			text: [ :each | each value name ifNil: [ each value gtDisplayString ] ];
		column: 'Combination'
			text: [ :each | each value combination gtDisplayString ];
		column: 'Element'
			icon: [ :each | 
				each key = self
					ifTrue: [ BlElement new size: 1 @ 1 ]
					ifFalse: [ BrButton new
							beSmallSize;
							label: each key gtDisplayString;
							aptitude: (BrGlamorousButtonLabelAptitude new
									hoveredColor: Color black;
									pressedColor: Color black)
									+ (BrGlamorousButtonRectangularAptitude
											paddingScale: 0.8
											heightScale: 0.85
											cornerRadius: 3)
									+ (BrStyleCommonAptitude new
											default: [ :s | s background: (Color gray alpha: 0.1) ];
											hovered: [ :s | s background: (Color gray alpha: 0.2) ];
											pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
							action: [ :aButtonElement | aButtonElement phlow spawnObject: each key ] ] ]
			width: 200;
		send: [  :each | each value ]
]
