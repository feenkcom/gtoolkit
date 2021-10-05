Extension { #name : #BaselineOfGToolkit }

{ #category : #'*GToolkit-Extensions' }
BaselineOfGToolkit class >> gtGtMapFor: aView [
	<gtView>
	<gtClassView>
	^ (self 
		gtMapFor: aView 
		selectRelationsThat: [ :a :b | 
			{'BaselineOfGToolkit' . 'BaselineOfXdoc' . 'BaselineOfBloc' . 'BaselineOfBrick' . 'BaselineOfSparta' . 'BaselineOfGlutin'} anySatisfy: [:prefix | 
			(a spec project configuration class name beginsWith: prefix) ] ]
		nameDisplayedAs: [ :aString | 
			aString asRopedText foreground: (({'GT' . 'Brick' . 'Bloc' . 'Sparta' . 'Xdoc' . 'Glutin'} anySatisfy: [:prefix | aString beginsWith: prefix ]) 
				ifTrue: [BrGlamorousColors linkColor] 
				ifFalse: [Color gray]) ])
			title: 'Gt Map'
]

{ #category : #'*GToolkit-Extensions' }
BaselineOfGToolkit class >> itself [
	<gtExample>
	^ self
]

{ #category : #'*GToolkit-Extensions' }
BaselineOfGToolkit class >> withAllContainedProjects [
	<gtExample>
	^ (self project version withDeepCollect: [ :each | each projects collect: #version ] as: Set) sorted: [ :a :b | a name < b name ]
]
