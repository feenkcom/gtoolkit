"
# Glamorous Toolkit
Glamorous Toolkit is the moldable development environment. It is a live notebook. It is a flexible search interface. It is a fancy code editor. It is a software analysis platform. It is a data visualization engine. All in one. It is built in Pharo and it is free and open-source under an MIT license.

Glamorous Toolkit offers a fundamentally new perspective on programming. We call it moldable development. We want the environment to fit the context of the current system and when it does not, we want to mold it seamlessly. This change is transformational.

Glamorous Toolkit has cool widgets and fancy code analyses, yet the emphasis is not on the features, but on the way you experience software. Take a look around to see how this feels, but do not stop there. Play with it. And engage with us. We'd love to hear from you: <https://gtoolkit.com>. 
## Moldable development
Glamorous Toolkit is not just a tool. It's a platform that embodies a new approach to software development. The core principle behind the Glamorous Toolkit is moldability. This means that any detail in the system can be viewed in multiple ways. This applies to handling static code, to inspecting individual objects, to debugging or to the way we search. To make this practical, the cost of creating a new view or interaction is small and in most cases the target is to extend the system live during the interaction.

Want to learn more? Take a look at a more detailed explanation of {{gtClass:GtMoldableDevelopmentExplanation|label=moldable development}}.
## Project organization
Glamorous Toolkit is made out of {{gtExample:BaselineOfGToolkit class>>#withAllContainedProjects|label=#size}} distinct, yet combinable, components. The picture below provides an overview of these components and their interdependencies. The map is navigable. Click on each component to learn more about it.

{{gtExample:BaselineOfGToolkit class>>#itself|previewShow=#gtGtMapFor:|noCode=|previewHeight=420}}
## Learn
### Inspector
Learn about it in {{gtClass:BaselineOfGToolkitInspector}}.
### Playground
Learn about it in {{gtClass:BaselineOfGToolkitPlayground}}.
### Documenter
This very document is edited and rendered through {{gtClass:BaselineOfGToolkitDocumenter}}.
### Coder
Coder offers a set of components that allow us to manipulate code. More details at: {{gtClass:BaselineOfGToolkitCoder}}.
## Spotter
Spotter is the universal search interface. Learn more at: {{gtClass:BaselineOfGToolkitSpotter}}.
### Examples and example-driven development
Examples offer both a new way to organize the test code and a bridge between the testing effort and documentation.

The introductory example-driven development tutorial:
[examples-tutorial.pillar](fileLocator://gtResource/feenkcom/gtoolkit-examples/doc/tutorial/examples-tutorial.pillar)

The exemplifying software tutorial based on a case study of face recognition using the Azure Face API:
[esug-2018-exemplifying-software.pillar](fileLocator://gtResource/feenkcom/gtoolkit-demos/doc/tutorial/esug-2018/esug-2018-exemplifying-software.pillar)
### Visualizer
Visualizer is a set of visualization engines to ease the creation of custom visualizations directly in the environment. Learn more at {{gtClass:BaselineOfGToolkitVisualizer}}.
### Transcript
This is a reimagining of the classic transcript by taking advantage of the text rendering possibilities. Learn more at {{gtClass:BaselineOfGToolkitTranscript}}.
### Releaser
Releaser is the engine for releasing deeply nested projects spread over multiple repositories. We are using it to release Glamorous Toolkit with it. Learn more at {{gtClass:BaselineOfGToolkitReleaser}}.
## A few words about the graphical stack
The Glamorous Toolkit is based on the Sparta/Bloc/Brick graphical stack. This stack has a few properties that make it distinct:
- it relies on one rendering tree at all times.
- it features moldable and scalable text editor is made out of elements. This means that we can embed text with graphics to obtain live editors.
- graph layouts are regular layouts. The implication here is that any element can be part of a graph-based visualization.
- debuggable. There are a significant amount of tools and mechanisms that are built for this.

Learn more about it: {{gtClass:GtWhatMakesBlocSpecialExplanation}}
## And about XDoc
What is XDoc? Learn here: {{gtClass:BaselineOfXdoc}}


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

{ #category : #accessing }
BaselineOfGToolkit class >> gtoolkitRepositorySpec [
	^ 'github://feenkcom/gtoolkit:main/src'
]

{ #category : #baseline }
BaselineOfGToolkit >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec preLoadDoIt: #'preLoadGToolkit:'.
		spec postLoadDoIt: #'postLoadGToolkit:'.
		spec
			baseline: 'GToolkitVirtualMachine' with: [
				spec repository: 'github://feenkcom/gtoolkit-vm-bindings:v0.6.12/src' ].
		spec
			baseline: 'GToolkitClipboard' with: [
				spec repository: 'github://feenkcom/gtoolkit-clipboard:v0.8.33/src' ].
		spec
			baseline: 'GToolkitPresenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-presenter:v0.8.527/src' ].
		spec
			baseline: 'GToolkitTranscript' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.8.1480/src' ].
		spec
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.8.851/src' ].
		spec
			baseline: 'GToolkitFileBrowser' with: [
				spec repository: 'github://feenkcom/gtoolkit-filebrowser:v0.6.436/src' ].
		spec
			baseline: 'GToolkitDemos' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.8.672/src' ].
		spec
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.8.120/src' ].
		spec
			baseline: 'RemoteRunner' with: [
				spec repository: 'github://feenkcom/gtoolkit-remoterunner:v0.6.105/src' ].
		spec
			baseline: 'GToolkitConstrainer' with: [
				spec repository: 'github://feenkcom/gtoolkit-constrainer:v0.8.9/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.432/src' ].
		spec
			baseline: 'GToolkit4SmaCC' with: [
				spec repository: 'github://feenkcom/gt4smacc:v0.8.117/src' ].
		spec
			baseline: 'GToolkit4XMLSupport' with: [
				spec repository: 'github://feenkcom/gt4xmlsupport:v0.8.15/src' ].
		spec
			baseline: 'GToolkit4PetitParser2' with: [
				spec repository: 'github://feenkcom/gt4petitparser2:v0.8.16/src' ].
		spec
			baseline: 'GToolkit4Famix3' with: [
				spec repository: 'github://feenkcom/gt4famix3:v0.8.41/src' ].
		spec
			baseline: 'GToolkit4Ruby' with: [
				spec repository: 'github://feenkcom/gt4ruby:v0.6.6/src' ].
		spec
			baseline: 'GtGemstoneClient' with: [
				spec repository: 'github://feenkcom/gt4gemstone:v0.6.443/src' ].
		spec
			baseline: 'GToolkit4Git' with: [
				spec repository: 'github://feenkcom/gt4git:v0.8.263/src' ].
		spec
			baseline: 'GToolkit4Changes' with: [
				spec repository: 'github://feenkcom/gt4changes:v0.6.58/src' ].
		spec
			baseline: 'GToolkit4Jenkins' with: [
				spec repository: 'github://feenkcom/gt4jenkins:v0.8.28/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.733/src' ].
		spec
			baseline: 'Gt4PharoLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote:v0.8.798/src' ].
		spec
			baseline: 'GToolkitMorphic' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.8.1480/src' ].
		spec
			baseline: 'BlocExtensions' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.340/src' ].
		spec
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.651/src' ].
		spec
			baseline: 'GToolkitPager' with: [
				spec repository: 'github://feenkcom/gtoolkit-pager:v0.8.610/src' ].
		spec
			baseline: 'GToolkitSpotter' with: [
				spec repository: 'github://feenkcom/gtoolkit-spotter:v0.8.579/src' ].
		spec
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc:v0.8.506/src' ].
		spec
			baseline: 'LepiterEngine' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.548/src' ].
		spec
			baseline: 'GToolkit4Magritte' with: [
				spec repository: 'github://feenkcom/gt4magritte:v0.6.122/src' ].
		spec
			baseline: 'RBFormatter' with: [
				spec repository: 'github://j-brant/RBFormatter:6b6f6829584c0d8b602b8e6b61826bdf80b48631/src' ].

		spec package: 'GToolkit-Extensions' with: [
			spec requires: #('GToolkitCoder' 'GToolkit4Pharo' 'GToolkitSpotter') ].
		spec package: 'GToolkit-Monitor' with: [
			spec requires: #('LepiterEngine' 'GToolkitVisualizerPhlow') ].
		spec package: 'GToolkit-SceneDriller' with: [
			spec requires: #('GToolkitVisualizerPhlow' 'GToolkitPager') ].
		spec package: 'GToolkit-World' with: [
			spec requires: #('GToolkit-SceneDriller' 'GToolkitFileBrowser' 'LepiterEngine' 'GToolkit4Git' 'GToolkitTranscript' 'GToolkit-Monitor' 'GToolkitReleaser' 'XdocClient') ].
		spec package: 'GToolkit-Notifications' with: [
			spec requires: #('GToolkitDebugger' 'GToolkit-World') ].
		spec package: 'GToolkit-Profiler' with: [
			spec requires: #('LepiterEngine' 'GToolkitVisualizerPhlow' 'GToolkit-Notifications') ].
		spec package: 'GToolkit-Docs' with: [
			spec requires: #('GToolkitCoder' 'GToolkit-World') ].
		spec package: 'GToolkit-Setup' with: [
			spec requires: #('GToolkitReleaser' 'GToolkitDebugger' 'LepiterEngine') ].
		spec package: 'GToolkit-DependencyAnalyzer'.
		spec package: 'GToolkit-Constraints' with: [
			spec requires: #('GToolkitConstrainer' 'GToolkit-DependencyAnalyzer' 'LepiterEngine') ].
	]
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
	
	SystemVersion current major = 7 ifTrue: [ 
		self fixCommandLineHandlerForPharo7 ].
	SystemVersion current major = 8 ifTrue: [ 
		self fixCommandLineHandlerForPharo8 ].
	
	(self class environment at: #GtNotificationBadgePublisher) beActivated.
	(self class environment at: #GtNotificationIcebergCredentialsProvider) beDefaultProvider.
	
	(self class environment at: #GtImage) setupLepiterIntegration.
	
	(self class environment at: #RBConfigurableFormatter)
		parenthesizeCascadeReceiver: false;
		retainBlankLinesBetweenStatements: true
]

{ #category : #'post load' }
BaselineOfGToolkit >> preLoadGToolkit: spec [

	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true.
	
	Author fullName: 'GlamorousAuthor'.
]
