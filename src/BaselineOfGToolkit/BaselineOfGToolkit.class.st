"
!Glamorous Toolkit

The Glamorous Toolkit (GT) is the moldable integrated development environment. For Pharo. It is made of components that are programmable inexpensively while using the tool itself. And it is open-source under an MIT license.

What's interesting about it? It offers a fundamentally new perspective on how programs can be approached. It's not the features that make the difference. Yes, we do have cool widgets and fancy code analyses, but our goal is to change the way you experience software. You can read about it, but to understand it, you have to play with it.

And engage with us. We'd love to hear from you: *https://gtoolkit.com*. 


!!Project organization

Glamorous Toolkit is an umbrella project that puts together several subprojects. The picture below provides an overview of these projects and their interdependencies. The map is navigable. Click on each component to learn more about it.

${example:BaselineOfGToolkit class>>#itself|previewShow=#gtGtMapFor:||noCode=|previewHeight=300}$


!!Moldable development

The core principle behind the Glamorous Toolkit is moldability. This means that any object in the system can have multiple views and ways to be interacted with. This applies to handling static code, to inspecting individual objects, to debugging and to the way we search. To make this practical, the cost of creating a new view or interaction is small and in most cases the target is to extend the system live during the interaction. Throughout the whole environment the way to extend the environment is directly explorable.

As an example, let us consider inspecting the object corresponding to the current working directory. A default inspector would show this. It's an accurate description of the variables of the ${class:FileReference}$ instance.

${example:FileReference class>>#gtExampleDirectory|noCode|previewShow=#gtRawFor:|previewHeight=150}$

Now consider this view of the same object.

${example:FileReference class>>#gtExampleDirectory|noCode|previewShow=#gtItemsFor:|previewHeight=150}$

Which one is more recognizable? Which one makes you feel more comfortable relating to. Likely the second one. We do not have to think whether the instance represents a file or a directory. The view clearly shows a the contents of the directory through a view that is common in file browsers. 

While the first view is generic in that it is applicable to any object, the second one is useful exactly because it is specific. In fact, each point of view can benefit from a specific view. It is for this reason that the inspector offers multiple views and enables you to craft your own for every single object.

${example:FileReference class>>#gtExampleDirectory|noCode|previewHeight=200}$

To exploit the full potential of the Glamorous Toolkit you need to contextualize it by programming it. To this end, the Glamorous Toolkit offers multiple ways to extend the tools and to express views and other interactions. Throughout the environment the goal of the engines is to make the cost of custom tools to be as inexpensive as possible.

This little change in perspective has a dramatic influence on how you can approach software systems. We call this moldable development. Want to learn more? Take a look at: ${class:GtMoldableDevelopmentExamples}$.


!!Learn


!!!Inspector
Learn about it in ${class:BaselineOfGToolkitInspector}$.


!!!Playground
Learn about it in ${class:BaselineOfGToolkitPlayground}$.


!!!Documenter
This very document is edited and rendered through ${class:BaselineOfGToolkitDocumenter}$. Take a look at the demo file here:
${icebergFile:path=feenkcom/gtoolkit-demos/doc/tutorial/esug-2018-documenter/documenter.pillar}$


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


!!A few words about the graphical stack
The Glamorous Toolkit is based on the SpartaBloc/Brick graphical stack. This stack has a few properties that make it distinct:
- it relies on one rendering tree at all times.
- it features moldable and scalable text editor is made out of elements. This means that we can embed text with graphics to obtain live editors.
- graph layouts are regular layouts. The implication here is that any element can be part of a graph-based visualization.
- debuggable. There are a significant amount of tools and mechanisms that are built for this.

Learn more about it at ${class:GtWhatMakesBlocSpecialExamples}$
!! Blog
${xdocs}$


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
	spec for: #'common' do: [
		spec 
			baseline: 'GToolkitDocumenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-documenter:v0.4.7/src' ];
			baseline: 'GToolkitTranscript' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.4.9/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.4.7/src' ];
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.4.7/src' ];
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.4.7/src' ];
			baseline: 'GToolkitPlayground' with: [
				spec repository: 'github://feenkcom/gtoolkit-playground:v0.4.6/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.4.7/src' ];
			baseline: 'GToolkitCognitiveServiceDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.4.5/src' ];
			baseline: 'GToolkitObjectNeuralNetworkDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.4.5/src' ];
			baseline: 'GToolkitWhatMakesBlocSpecialDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.4.5/src' ];
			baseline: 'GToolkitMoldableDevelopmentDemo' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.4.5/src' ];
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.4.7/src' ];
			baseline: 'GToolkitConstrainer' with: [
				spec repository: 'github://feenkcom/gtoolkit-constrainer:v0.4.1/src' ].
		spec 
			package: 'GToolkit-Scenery';
			package: 'GToolkit-World'. ].

]
