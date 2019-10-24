"
!Glamorous Toolkit

Glamorous Toolkit is the moldable development environment. It is a live notebook. It is a flexible search interface. It is a fancy code editor. It is a software analysis platform. It is a data visualization engine. All in one. It is built in Pharo and it is free and open-source under an MIT license.

Glamorous Toolkit offers a fundamentally new perspective on programming. We call it moldable development. We want the environment to fit the context of the current system and when it does not, we want to mold it seamlessly. This change is transformational.

Glamorous Toolkit has cool widgets and fancy code analyses, yet the emphasis is not on the features, but on the way you experience software. Take a look around to see how this feels, but do not stop there. Play with it. And engage with us. We'd love to hear from you: *https://gtoolkit.com*. 


!!Project organization

Glamorous Toolkit is made out of independent, yet combinable, components. The picture below provides an overview of these components and their interdependencies. The map is navigable. Click on each component to learn more about it.

${example:BaselineOfGToolkit class>>#itself|previewShow=#gtGtMapFor:||noCode=|previewHeight=300}$


!!Moldable development

Glamorous Toolkit is not just a tool. It's a platform that embodies a new approach to software development. The core principle behind the Glamorous Toolkit is moldability. This means that any object in the system can have multiple views and ways to be interacted with. This applies to handling static code, to inspecting individual objects, to debugging and to the way we search. To make this practical, the cost of creating a new view or interaction is small and in most cases the target is to extend the system live during the interaction.

Just take a look at these slides. They show the same objects. The generic view shows all objects in the same way. The contextual views take, well, context into account. The generic view is generic. The contextual view is valuable because we can relate to the specifics of the object. This is important because the value of software lies in the specifics.

${slides:list=#(GtRawViewsSlide GtCustomViewsSlide GtAllViewsSlide)|show=#gtLiveFor:|height=500}$

Want to learn more? Take a look at: ${class:GtMoldableDevelopmentExplanation}$.


!!Learn


!!!Inspector
Learn about it in ${class:BaselineOfGToolkitInspector}$.


!!!Playground
Learn about it in ${class:BaselineOfGToolkitPlayground}$.


!!!Documenter
This very document is edited and rendered through ${class:BaselineOfGToolkitDocumenter}$.


!!!Coder
Coder offers a set of components that allow us to manipulate code. More details at: ${class:BaselineOfGToolkitCoder}$.


!!!Examples and example-driven development
Examples offer both a new way to organize the test code and a bridge between the testing effort and documentation.

The introductory example-driven development tutorial:
${icebergFile:path=feenkcom/gtoolkit-examples/doc/tutorial/examples-tutorial.pillar}$

The exemplifying software tutorial based on a case study of face recognition using the Azure Face API:
${icebergFile:path=feenkcom/gtoolkit-demos/doc/tutorial/esug-2018/esug-2018-exemplifying-software.pillar}$


!!!Visualizer
Visualizer is a set of visualization engines to ease the creation of custom visualizations directly in the environment. Learn more at ${class:BaselineOfGToolkitVisualizer}$.


!!!Transcript
This is a reimagining of the classic transcript by taking advantage of the text rendering possibilities. Learn more at ${class:BaselineOfGToolkitTranscript}$.

!!!Releaser
Releaser is the engine for releasing deeply nested projects spread over multiple repositories. We are using it to release Glamorous Toolkit with it. Learn more at ${class:BaselineOfGToolkitReleaser}$.


!!A few words about the graphical stack

The Glamorous Toolkit is based on the SpartaBloc/Brick graphical stack. This stack has a few properties that make it distinct:
- it relies on one rendering tree at all times.
- it features moldable and scalable text editor is made out of elements. This means that we can embed text with graphics to obtain live editors.
- graph layouts are regular layouts. The implication here is that any element can be part of a graph-based visualization.
- debuggable. There are a significant amount of tools and mechanisms that are built for this.

Learn more about it: ${class:GtWhatMakesBlocSpecialExplanation}$


!!feenk blog

This is our blog. Each post below is delivered fresh from our XDoc bakery.

${xdocs}$

What is XDoc? Learn here: ${class:BaselineOfXdoc}$


"
Class {
	#name : #BaselineOfGToolkit,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded',
		'PreLoaded'
	],
	#category : #BaselineOfGToolkit
}

{ #category : #ui }
BaselineOfGToolkit class >> gtGtMapFor: aView [
	<gtView>
	^ (self 
		gtMapFor: aView 
		selectRelationsThat: [ :a :b | 
			(a spec project configuration class name beginsWith: 'BaselineOfGToolkit') or: [ 
				a spec project configuration class name beginsWith: 'BaselineOfXdoc' ] ]
		nameDisplayedAs: [ :aString | 
			aString asRopedText foreground: (((aString beginsWith: 'GT') or: [ aString beginsWith: 'Xdoc' ]) 
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
	spec for: #'common' do: [
		spec preLoadDoIt: #'preLoadGToolkit:'.
		spec postLoadDoIt: #'postLoadGToolkit:'.
		spec 
			baseline: 'GToolkitClipboard' with: [
				spec repository: 'github://feenkcom/gtoolkit-clipboard:v0.6.11/src' ];
			baseline: 'GToolkitDocumenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-documenter:v0.7.184/src' ];
			baseline: 'GToolkitPresenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-presenter:v0.6.79/src' ];
			baseline: 'GToolkitTranscript' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.7.274/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.7.138/src' ];
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.7.156/src' ];
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.7.167/src' ];
			baseline: 'GToolkitPlayground' with: [
				spec repository: 'github://feenkcom/gtoolkit-playground:v0.7.146/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.7.152/src' ];
			baseline: 'GToolkitSpotter' with: [
				spec repository: 'github://feenkcom/gtoolkit-spotter:v0.7.139/src' ];
			baseline: 'GToolkitCognitiveServiceDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.7.133/src' ];
			baseline: 'GToolkitObjectNeuralNetworkDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.7.133/src' ];
			baseline: 'GToolkitWhatMakesBlocSpecialDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.7.133/src' ];
			baseline: 'GToolkitMoldableDevelopmentDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.7.133/src' ];
			baseline: 'GToolkitPharo101' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.7.133/src' ];
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.7.19/src' ];
			baseline: 'GToolkitConstrainer' with: [
				spec repository: 'github://feenkcom/gtoolkit-constrainer:v0.7.2/src' ];
			baseline: 'GToolkit4SmaCC' with: [
				spec repository: 'github://feenkcom/gt4smacc:v0.7.38/src' ];
			baseline: 'GToolkit4PetitParser2' with: [
				spec repository: 'github://feenkcom/gt4petitparser2:v0.7.2/src' ];
			baseline: 'GToolkit4Famix3' with: [
				spec repository: 'github://feenkcom/gt4famix3:v0.7.17/src' ].
		spec 
			package: 'GToolkit-Scenery';
			package: 'GToolkit-Monitor';
			package: 'GToolkit-Constraints' with: [
				spec requires: #('GToolkitConstrainer' 'GToolkitDocumenter' ). ];
			package: 'GToolkit-World'. ].

]

{ #category : #'post load' }
BaselineOfGToolkit >> fixCommandLineHandlerForPharo7 [
	BasicCommandLineHandler compile: ((BasicCommandLineHandler>>#gtHandleArgument:) sourceCode
		copyReplaceAll: 'gtHandleArgument: aString' with: 'handleArgument: aString').
	EvaluateCommandLineHandler compile: ((EvaluateCommandLineHandler>>#gtArgumentString) sourceCode
		copyReplaceAll: 'gtArgumentString' with: 'argumentString')
]

{ #category : #'post load' }
BaselineOfGToolkit >> fixCommandLineHandlerForPharo8 [
	EvaluateCommandLineHandler compile: ((EvaluateCommandLineHandler>>#gtArgumentString) sourceCode
		copyReplaceAll: 'gtArgumentString' with: 'argumentString')
]

{ #category : #'post load' }
BaselineOfGToolkit >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
	PostLoaded := true.
	
	GtMoldableDebuggerElement register.
	
	SystemVersion current major = 7 ifTrue: [ 
		self fixCommandLineHandlerForPharo7 ].
	SystemVersion current major = 8 ifTrue: [ 
		self fixCommandLineHandlerForPharo8 ].
]

{ #category : #'post load' }
BaselineOfGToolkit >> preLoadGToolkit: spec [
	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true.
	
	Author fullName: 'GlamorousAuthor'
]
