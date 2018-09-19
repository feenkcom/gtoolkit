"
!Glamorous Toolkit

The Glamorous Toolkit (GT) is the moldable integrated development environment. For Pharo. It is made of components that are programmable inexpensively while using the tool itself. And it is open-source under an MIT license.

What's interesting about it? It offers a fundamentally new perspective on how programs can be approached. It's not the features that make the difference. Yes, we do have cool widgets and fancy code analyses, but our goal is to change the way you experience software. You can read about it, but to understand it, you have to play with it.

And engage with us. We'd love to hear from you: *https://feenk.com/gt*. 

!!Organization

Glamorous Toolkit is an umbrella project that puts together several subprojects. The picture below provides an overview of these projects and their interdependencies.

${example:BaselineOfGToolkit class>>#itself|show=#gtGtMapFor:|expandedPreview=true|noCode=|previewHeight=300}$


!!Learn



!!!Documenter

This very document is edited and rendered through Documenter. Take a look at the demo file here:
${inputFile:path=pharo-local/iceberg/feenkcom/gtoolkit-demos/doc/tutorial/esug-2018-documenter/documenter.pillar}$


!!!Example-driven development

The introductory example-driven development tutorial:
${inputFile:path=pharo-local/iceberg/feenkcom/gtoolkit-examples/doc/tutorial/examples-tutorial.pillar}$

The exemplifying software tutorial based on a case study of face recognition using the Azure Face API:
${inputFile:path=pharo-local/iceberg/feenkcom/gtoolkit-demos/doc/tutorial/esug-2018/esug-2018-exemplifying-software.pillar}$

!!!Mondrian

Mondrian is the engine that allows you to script a graph visualization:
${inputFile:path=pharo-local/iceberg/feenkcom/gtoolkit-visualizer/doc/mondrian/index.pillar}$

!!!Transcript

This is a reimagining of the classic transcript by taking advantage of the text rendering possibilities behind GT:
${inputFile:path=pharo-local/iceberg/feenkcom/gtoolkit/doc/transcript/index.pillar}$


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
				ifTrue: [BrGlamorousColors linkColor] 
				ifFalse: [Color gray]) ])
			title: 'Gt Map'
]

{ #category : #ui }
BaselineOfGToolkit class >> itself [
	<gtExample>
	^ self
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
				spec repository: 'github://feenkcom/gtoolkit-coder/src' ];
			baseline: 'GToolkitCognitiveServiceDemo' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-demos/src' ];
			baseline: 'GToolkitObjectNeuralNetworkDemo' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-demos/src' ]
	]

]
