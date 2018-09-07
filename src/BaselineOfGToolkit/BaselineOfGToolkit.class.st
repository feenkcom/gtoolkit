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
	#category : #BaselineOfGToolkit
}

{ #category : #ui }
BaselineOfGToolkit class >> gtGtMapFor: aView [
	<gtView>
	^ (self 
		gtMapFor: aView 
		selectRelationsThat: [ :a :b | 
			a spec project configuration class name beginsWith: 'BaselineOfGToolkit' ]
		nameDisplayedAs: [ :aString | 
			aString asRopedText foreground: ((aString beginsWith: 'GT') 
				ifTrue: [Color black] 
				ifFalse: [Color gray]) ])
			title: 'Gt Map'
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
			baseline: 'GToolkitDebugger' with: [ 
				spec 	repository: 'github://feenkcom/gtoolkit-debugger/src' ];
			baseline: 'GToolkitPlayground' with: [ 
				spec 	repository: 'github://feenkcom/gtoolkit-playground/src' ];
			baseline: 'GToolkitCoder' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-coder/src' ]
	]

]
