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
BaselineOfGToolkit class >> fullBaselineProject [
	"Return a project for the main baseline used to load Glamorous Toolkit."
	
	^ BaselineOfGToolkitForPharo9 
		gtRlProjectWithRepository: self gtoolkitRepositorySpec.
]

{ #category : #accessing }
BaselineOfGToolkit class >> gtRlAllValidRPackages [
	| gtProject allPackages |
	
	gtProject := self fullBaselineProject.
	allPackages := gtProject allPPackages.
	^ allPackages reject: [ :aPackage | aPackage isNil ]
]

{ #category : #accessing }
BaselineOfGToolkit class >> gtoolkitRepositorySpec [
	^ 'github://feenkcom/gtoolkit:main/src'
]

{ #category : #baseline }
BaselineOfGToolkit >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec preLoadDoIt: #preLoadGToolkit:.
			spec postLoadDoIt: #postLoadGToolkit:.
			spec
				baseline: 'GToolkitVirtualMachine'
					with: [ spec repository: 'github://feenkcom/gtoolkit-vm-bindings:main/src' ];
				baseline: 'GToolkitClipboard'
					with: [ spec repository: 'github://feenkcom/gtoolkit-clipboard:main/src' ];
				baseline: 'GToolkitPresenter'
					with: [ spec repository: 'github://feenkcom/gtoolkit-presenter:main/src' ];
				baseline: 'GToolkitTranscript'
					with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ];
				baseline: 'GToolkitDebugger'
					with: [ spec repository: 'github://feenkcom/gtoolkit-debugger:main/src' ];
				baseline: 'GToolkitDebuggerExtensions'
					with: [ spec repository: 'github://feenkcom/gtoolkit-debugger:main/src' ];
				baseline: 'GToolkitFileBrowser'
					with: [ spec repository: 'github://feenkcom/gtoolkit-filebrowser:main/src' ];
				baseline: 'GToolkitDemos'
					with: [ spec repository: 'github://feenkcom/gtoolkit-demos:main/src' ];
				baseline: 'GToolkitReleaser'
					with: [ spec repository: 'github://feenkcom/gtoolkit-releaser:main/src' ];
				baseline: 'RemoteRunner'
					with: [ spec repository: 'github://feenkcom/gtoolkit-remoterunner:main/src' ];
				baseline: 'GToolkitConstrainer'
					with: [ spec repository: 'github://feenkcom/gtoolkit-constrainer:main/src' ];
				baseline: 'GToolkit4Pharo'
					with: [ spec repository: 'github://feenkcom/gt4pharo:main/src' ];
				baseline: 'GToolkit4SmaCC'
					with: [ spec repository: 'github://feenkcom/gt4smacc:main/src' ];
				baseline: 'GToolkit4XMLSupport'
					with: [ spec repository: 'github://feenkcom/gt4xmlsupport:main/src' ];
				baseline: 'GToolkit4PetitParser2'
					with: [ spec repository: 'github://feenkcom/gt4petitparser2:main/src' ];
				baseline: 'GToolkit4Famix3'
					with: [ spec repository: 'github://feenkcom/gt4famix3:main/src' ];
				baseline: 'GToolkit4Ruby'
					with: [ spec repository: 'github://feenkcom/gt4ruby:main/src' ];
				baseline: 'GToolkit4Python'
					with: [ spec repository: 'github://feenkcom/gt4python:main/src' ];
				baseline: 'GtGemstoneClient'
					with: [ spec repository: 'github://feenkcom/gt4gemstone:main/src' ];
				baseline: 'GToolkit4Git'
					with: [ spec repository: 'github://feenkcom/gt4git:main/src' ];
				baseline: 'GToolkit4GraphQL'
					with: [ spec repository: 'github://feenkcom/gt4graphql:main/src' ];
				baseline: 'GToolkit4Changes'
					with: [ spec repository: 'github://feenkcom/gt4changes:main/src' ];
				baseline: 'GToolkit4Jenkins'
					with: [ spec repository: 'github://feenkcom/gt4jenkins:main/src' ];
				baseline: 'GToolkit4LSP'
					with: [ spec repository: 'github://feenkcom/gt4lsp:main/src' ];
				baseline: 'GToolkit4Ops'
					with: [ spec repository: 'github://feenkcom/gt4ops:main/src' ];
				baseline: 'Gt4Aws'
					with: [ spec repository: 'github://feenkcom/gt4aws:main/src' ];
				baseline: 'GToolkitCoder'
					with: [ spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ];
				baseline: 'Gt4PharoLink'
					with: [ spec repository: 'github://feenkcom/gtoolkit-remote:main/src' ];
				baseline: 'GToolkitMorphic'
					with: [ spec repository: 'github://feenkcom/gtoolkit:main/src' ];
				baseline: 'BlocExtensions'
					with: [ spec repository: 'github://feenkcom/Bloc:main/src' ];
				baseline: 'GToolkitVisualizerPhlow'
					with: [ spec repository: 'github://feenkcom/gtoolkit-visualizer:main/src' ];
				baseline: 'GToolkitScenery'
					with: [ spec repository: 'github://feenkcom/gtoolkit-scenery:main/src' ];
				baseline: 'GToolkitPager'
					with: [ spec repository: 'github://feenkcom/gtoolkit-pager:main/src' ];
				baseline: 'GToolkitSpotter'
					with: [ spec repository: 'github://feenkcom/gtoolkit-spotter:main/src' ];
				baseline: 'GToolkitNotifications'
					with: [ spec repository: 'github://feenkcom/gtoolkit-notifications:main/src' ];
				baseline: 'GToolkitNotificationsExamples'
					with: [ spec repository: 'github://feenkcom/gtoolkit-notifications:main/src' ];
				baseline: 'GToolkitWebView'
					with: [ spec repository: 'github://feenkcom/gtoolkit-webview:main/src' ];
				baseline: 'XdocClient'
					with: [ spec repository: 'github://feenkcom/xdoc:main/src' ];
				baseline: 'LepiterEngine'
					with: [ spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'GToolkit4Magritte'
					with: [ spec repository: 'github://feenkcom/gt4magritte:main/src' ];
				baseline: 'GToolkit4OpenAPI'
					with: [ spec repository: 'github://feenkcom/gt4openapi:main/src' ];
				baseline: 'RBFormatter'
					with: [ spec repository: 'github://j-brant/RBFormatter/src' ];
				baseline: 'GToolkitWorld'
					with: [ spec repository: 'github://feenkcom/gtoolkit-world:main/src' ];
				baseline: 'GToolkitPhlowExamples'
					with: [ spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ];
				baseline: 'GToolkit4ZTimestamp'
					with: [ spec repository: 'github://feenkcom/gt4ztimestamp:main/src' ];
				baseline: 'Gt4Llm'
					with: [ spec repository: 'github://feenkcom/gt4llm:main/src' ];
				baseline: 'MethodProxiesForGlamorousToolkit' 
					with: [ spec repository: 'github://feenkcom/MethodProxies:gt-pharo11/src' ];
				baseline: 'GToolkitProfiler'
					with: [ spec repository: 'github://feenkcom/gtoolkit-profiler:main/src' ] ]
]

{ #category : #'post load' }
BaselineOfGToolkit >> postLoadGToolkit: spec [
	(PostLoaded isNotNil and: [ PostLoaded ]) ifTrue: [ ^ self ].
	PostLoaded := true.

	(self class environment at: #GtNotificationBadgePublisher) beActivated.
	(self class environment at: #GtNotificationIcebergCredentialsProvider)
		beDefaultProvider.

	(self class environment at: #GtImage) setupLepiterIntegration.

	(self class environment at: #RBConfigurableFormatter)
		maxLineLength: 80;
		newLineAfterPragma: false;
		sameLineKeywordArgument: true;
		parenthesizeCascadeReceiver: false;
		retainBlankLinesBetweenStatements: true.
]

{ #category : #'post load' }
BaselineOfGToolkit >> preLoadGToolkit: spec [

	(PreLoaded isNotNil and: [ PreLoaded ])
		ifTrue: [ ^ self ].
	PreLoaded := true.
	
	Author fullName: 'GlamorousAuthor'.
]
