"
!GToolkit organization

The Glamorous Toolkit (GT) is loaded based on ${class:BaselineOfGToolkit}$.

[[[
	BaselineOfGToolkit.
]]]

${class:BaselineOfGToolkit}$ defines an umbrella project that puts together several subprojects. These direct projects are:

[[[
	BaselineOfGToolkit project version projects.
]]]
"
Class {
	#name : #BaselineOfGToolkit,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGToolkit'
}

{ #category : #ui }
BaselineOfGToolkit class >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 10;
		painting: [ :mondrian |
			| projects |
			projects := Set new.
			self project version 
				withDeep: [ :each | each projects collect: #version ]
				relationDo: [:a :b | 
					(a spec project configuration class name beginsWith: 'BaselineOfGToolkit') 
					ifTrue: [ projects add: a; add: b ] ].
			mondrian nodes 
				shape: [:each | 
					| text |
					text := [
						| displayString |
						displayString := (((each gtDisplayString 
							copyReplaceAll: 'BaselineOf' with: '')
							copyReplaceAll: 'ConfigurationOf' with: '')
							copyReplaceAll: 'GToolkit' with: 'GT ').
						displayString asRopedText
							foreground: ((displayString beginsWith: 'GT') ifTrue: [Color black] ifFalse: [Color gray]) ]
						on: Error do: [:e | e asString asRopedText foreground: Color red ].
					BlTextElement new text: text; zIndex: 1 ];
				with: projects.
			mondrian edges
				shape: [ :each |
					BlLineElement new 
						zIndex: 0;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))  ];
				fromNearestBounds;
				toNearestBounds;
				connectFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			mondrian layout horizontalTree levelDistance: 50; nodeDistance: 10]
]

{ #category : #baseline }
BaselineOfGToolkit >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitDocumenter' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-documenter/src' ];
			baseline: 'GToolkitTranscript' with: [ 
				spec repository: 'github://feenkcom/gtoolkit/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ];
			baseline: 'GToolkitInspector' with: [ 
				spec 	repository: 'github://feenkcom/gtoolkit-inspector/src' ];
			baseline: 'GToolkitPlayground' with: [ 
				spec 	repository: 'github://feenkcom/gtoolkit-playground/src' ]
	]

]
