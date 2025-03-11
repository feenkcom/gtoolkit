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
	spec for: #'common' do: [
		spec preLoadDoIt: #'preLoadGToolkit:'.
		spec postLoadDoIt: #'postLoadGToolkit:'.
		spec
			baseline: 'GToolkitVirtualMachine' with: [
				spec repository: 'github://feenkcom/gtoolkit-vm-bindings:v0.6.27/src' ].
		spec
			baseline: 'GToolkitClipboard' with: [
				spec repository: 'github://feenkcom/gtoolkit-clipboard:v0.8.64/src' ].
		spec
			baseline: 'GToolkitPresenter' with: [
				spec repository: 'github://feenkcom/gtoolkit-presenter:v0.8.2179/src' ].
		spec
			baseline: 'GToolkitTranscript' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.1569/src' ].
		spec
			baseline: 'GToolkitDebugger' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.8.2644/src' ].
		spec
			baseline: 'GToolkitDebuggerExtensions' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugger:v0.8.2644/src' ].
		spec
			baseline: 'GToolkitFileBrowser' with: [
				spec repository: 'github://feenkcom/gtoolkit-filebrowser:v0.6.2184/src' ].
		spec
			baseline: 'GToolkitDemos' with: [
				spec repository: 'github://feenkcom/gtoolkit-demos:v0.8.2921/src' ].
		spec
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.8.268/src' ].
		spec
			baseline: 'RemoteRunner' with: [
				spec repository: 'github://feenkcom/gtoolkit-remoterunner:v0.6.1512/src' ].
		spec
			baseline: 'GToolkitConstrainer' with: [
				spec repository: 'github://feenkcom/gtoolkit-constrainer:v0.8.17/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.2051/src' ].
		spec
			baseline: 'GToolkit4SmaCC' with: [
				spec repository: 'github://feenkcom/gt4smacc:v0.8.342/src' ].
		spec
			baseline: 'GToolkit4XMLSupport' with: [
				spec repository: 'github://feenkcom/gt4xmlsupport:v0.8.30/src' ].
		spec
			baseline: 'GToolkit4PetitParser2' with: [
				spec repository: 'github://feenkcom/gt4petitparser2:v0.8.43/src' ].
		spec
			baseline: 'GToolkit4Famix3' with: [
				spec repository: 'github://feenkcom/gt4famix3:v0.8.109/src' ].
		spec
			baseline: 'GToolkit4Ruby' with: [
				spec repository: 'github://feenkcom/gt4ruby:v0.6.22/src' ].
		spec
			baseline: 'GToolkit4Python' with: [
				spec repository: 'github://feenkcom/gt4python:v0.6.1119/src' ].
		spec
			baseline: 'GtGemstoneClient' with: [
				spec repository: 'github://feenkcom/gt4gemstone:v0.6.2875/src' ].
		spec
			baseline: 'GToolkit4Git' with: [
				spec repository: 'github://feenkcom/gt4git:v0.8.1390/src' ].
		spec
			baseline: 'GToolkit4GraphQL' with: [
				spec repository: 'github://feenkcom/gt4graphql:v0.6.1894/src' ].
		spec
			baseline: 'GToolkit4Changes' with: [
				spec repository: 'github://feenkcom/gt4changes:v0.6.1036/src' ].
		spec
			baseline: 'GToolkit4Jenkins' with: [
				spec repository: 'github://feenkcom/gt4jenkins:v0.8.59/src' ].
		spec
			baseline: 'GToolkit4LSP' with: [
				spec repository: 'github://feenkcom/gt4lsp:v0.6.611/src' ].
		spec
			baseline: 'GToolkit4Ops' with: [
				spec repository: 'github://feenkcom/gt4ops:v0.6.93/src' ].
		spec
			baseline: 'Gt4Aws' with: [
				spec repository: 'github://feenkcom/gt4aws:v0.6.27/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.1975/src' ].
		spec
			baseline: 'Gt4PharoLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote:v0.8.1920/src' ].
		spec
			baseline: 'GToolkitMorphic' with: [
				spec repository: 'github://feenkcom/gtoolkit:v1.0.1569/src' ].
		spec
			baseline: 'BlocExtensions' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.782/src' ].
		spec
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.2145/src' ].
		spec
			baseline: 'GToolkitScenery' with: [
				spec repository: 'github://feenkcom/gtoolkit-scenery:v0.6.717/src' ].
		spec
			baseline: 'GToolkitPager' with: [
				spec repository: 'github://feenkcom/gtoolkit-pager:v0.8.1579/src' ].
		spec
			baseline: 'GToolkitSpotter' with: [
				spec repository: 'github://feenkcom/gtoolkit-spotter:v0.8.1499/src' ].
		spec
			baseline: 'GToolkitNotifications' with: [
				spec repository: 'github://feenkcom/gtoolkit-notifications:v0.6.1165/src' ].
		spec
			baseline: 'GToolkitNotificationsExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-notifications:v0.6.1165/src' ].
		spec
			baseline: 'GToolkitWebView' with: [
				spec repository: 'github://feenkcom/gtoolkit-webview:v0.6.211/src' ].
		spec
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc:v0.8.823/src' ].
		spec
			baseline: 'LepiterEngine' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.2875/src' ].
		spec
			baseline: 'GToolkit4Magritte' with: [
				spec repository: 'github://feenkcom/gt4magritte:v0.6.1217/src' ].
		spec
			baseline: 'GToolkit4OpenAPI' with: [
				spec repository: 'github://feenkcom/gt4openapi:v0.6.12/src' ].
		spec
			baseline: 'RBFormatter' with: [
				spec repository: 'github://j-brant/RBFormatter:905d60c1d93cecd75456e4a011cae240581976b5/src' ].
		spec
			baseline: 'GToolkitWorld' with: [
				spec repository: 'github://feenkcom/gtoolkit-world:v0.6.1506/src' ].
		spec
			baseline: 'GToolkitPhlowExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-phlow:v0.8.1574/src' ].
		spec
			baseline: 'GToolkit4ZTimestamp' with: [
				spec repository: 'github://feenkcom/gt4ztimestamp:v0.6.11/src' ].
		spec
			baseline: 'Gt4Llm' with: [
				spec repository: 'github://feenkcom/gt4llm:v0.6.46/src' ].
		spec
			baseline: 'MethodProxiesForGlamorousToolkit' with: [
				spec repository: 'github://feenkcom/MethodProxies:v0.6.0/src' ].
		spec
			baseline: 'GToolkitProfiler' with: [
				spec repository: 'github://feenkcom/gtoolkit-profiler:v0.6.7/src' ].
	]
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
