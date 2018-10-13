"
!Glamorous Toolkit

The Glamorous Toolkit (GT) is the moldable integrated development environment. For Pharo. It is made of components that are programmable inexpensively while using the tool itself. And it is open-source under an MIT license.

What's interesting about it? It offers a fundamentally new perspective on how programs can be approached. It's not the features that make the difference. Yes, we do have cool widgets and fancy code analyses, but our goal is to change the way you experience software. You can read about it, but to understand it, you have to play with it.

And engage with us. We'd love to hear from you: *https://feenk.com/gt*. 

!!Organization

Glamorous Toolkit is an umbrella project that puts together several subprojects. The picture below provides an overview of these projects and their interdependencies. The map is naviagable. Click on each component to learn more about it.

${example:BaselineOfGToolkit class>>#itself|show=#gtGtMapFor:|expandedPreview=true|noCode=|previewHeight=300}$



!!Moldable development

The core principle behind the Glamorous Toolkit is moldability. This means that any object in the system can have multiple views and ways to be interacted with. This applies to handling static code, to inspecting individual objects, to debugging and to the way we search. To make this practical, the cost of creating a new view or interaction is small and in most cases the target is to extend the system live during the interaction. Throughout the whole environment the way to extend the environment is directly explorable.

Let us consider an example.

${example:FileReference class>>#gtExampleDirectory|noCode}$

The examples above shows an instance of ${class:FileReference}$. As the object points to a folder, the first view shows the contents of the object through a view that is common in file browsers. This view stands in contrast with the default Raw view which shows the internal state of the object. While the Raw view is generic in that it is applicable to any object, the contextualized view is powerful in that it allows us to understand and interact with the object.

To exploit the full potential of the Glamorous Toolkit you need to contextualize it by programming it. To this end, the Glamorous Toolkit offers multiple ways to extend the tools and to express views and other interactions. Throughout the environment the goal of the engines is to make the cost of custom tools to be as inexpensive as possible.


!!Learn

!!Inspector
Learn about it in ${class:BaselineOfGToolkitInspector}$.


!!!Documenter
This very document is edited and rendered through ${class:BaselineOfGToolkitDocumenter}$. Take a look at the demo file here:
${icebergFile:path=feenkcom/gtoolkit-demos/doc/tutorial/esug-2018-documenter/documenter.pillar}$


!!!Example-driven development
Examples offer both a new way to organize the test code and a bridge between the testing effort and documentation.

The introductory example-driven development tutorial:
${icebergFile:path=feenkcom/gtoolkit-examples/doc/tutorial/examples-tutorial.pillar}$

The exemplifying software tutorial based on a case study of face recognition using the Azure Face API:
${icebergFile:path=feenkcom/gtoolkit-demos/doc/tutorial/esug-2018/esug-2018-exemplifying-software.pillar}$


!!!Mondrian
Mondrian is the engine that allows you to script a graph visualization:
${icebergFile:path=feenkcom/gtoolkit-visualizer/doc/mondrian/index.pillar}$


!!!Transcript
This is a reimagining of the classic transcript by taking advantage of the text rendering possibilities. Learn more at ${class:BaselineOfGToolkitTranscript}$.


!!!A few words about the graphical stack

The Glamorous Toolkit is based on the SpartaBloc/Brick graphical stack. This stack has a few properties that make it distinct:
- it relies on one rendering tree at all times.
- it features moldable and scalable text editor is made out of elements. This means that we can embed text with graphics to obtain live editors.
- graph layouts are regular layouts. The implication here is that any element can be part of a graph-based visualization.
- debuggable. There are a significant amount of tools and mechanisms that are built for this.

Learn more about it at ${class:GtWhatMakesBlocSpecialExamples}$



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
				spec repository: 'github://feenkcom/gtoolkit-demos/src' ];
			baseline: 'GToolkitWhatMakesBlocSpecialDemo' with: [ 
				spec repository: 'github://feenkcom/gtoolkit-demos/src' ]
	]

]
