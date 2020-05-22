SourceFileArray compile: 'deferFlushDuring: aBlock	
	flushChanges ifFalse: [ ^ aBlock value ].
	"flushChanges := false."
	^ [ aBlock value ] ensure: [
		flushChanges := true.
		self flushChangesFile ]'.

[ 
EpMonitor current disable.
Metacello new
    githubUser: 'pharo-vcs' project: 'Iceberg' commitish: 'dev-1.6' path: '';
    baseline: 'Iceberg';
    load.

Metacello new baseline: 'Beacon'; repository: 'github://feenkcom/pharo-beacon/repository'; load.
Metacello new baseline: 'GToolkitInstaller'; repository: 'github://feenkcom/gtoolkit-installer/src'; load.
Metacello new baseline: 'GToolkitBoxer'; repository: 'github://feenkcom/gtoolkit-boxer/src'; load.
Metacello new baseline: 'GToolkitClipboard'; repository: 'github://feenkcom/gtoolkit-clipboard/src'; load.
Metacello new baseline: 'SmaCC'; repository: 'github://j-brant/SmaCC/src'; load.
Metacello new baseline: 'GToolkitExamplesEngine'; repository: 'github://feenkcom/gtoolkit-examples/src'; load.
Metacello new baseline: 'GToolkitExamples'; repository: 'github://feenkcom/gtoolkit-examples/src'; load.
Metacello new baseline: 'Sparta'; repository: 'github://feenkcom/Sparta/src'; load.
Metacello new baseline: 'SpartaCore'; repository: 'github://feenkcom/Sparta/src'; load.
Metacello new baseline: 'SpartaCairo'; repository: 'github://feenkcom/Sparta/src'; load.
Metacello new baseline: 'SpartaSkia'; repository: 'github://feenkcom/Sparta/src'; load.
Metacello new baseline: 'TaskIt'; repository: 'github://sbragagnolo/taskit:v1.0.2'; load.
Metacello new baseline: 'ThreadedFFI'; repository: 'github://feenkcom/threadedFFI-Plugin'; load.
Metacello new baseline: 'ThreadedFFIMigration'; repository: 'github://feenkcom/threadedFFI-Plugin'; load.
Metacello new baseline: 'GtThreadedFFIDev'; repository: 'github://feenkcom/tffi-dev/src'; load.
Metacello new baseline: 'BeaconFFI'; repository: 'github://feenkcom/tffi-dev/src'; load.
Metacello new baseline: 'GToolkitGleam'; repository: 'github://feenkcom/gtoolkit-gleam/src'; load.
Metacello new baseline: 'GToolkitFenster'; repository: 'github://feenkcom/gtoolkit-fenster/src'; load.
Metacello new baseline: 'Glutin'; repository: 'github://feenkcom/gtoolkit-glutin/src'; load.
Metacello new baseline: 'GToolkitResourcesUtility'; repository: 'github://feenkcom/gtoolkit-utility/src'; load.
Metacello new baseline: 'GToolkitUtility'; repository: 'github://feenkcom/gtoolkit-utility/src'; load.
Metacello new baseline: 'GToolkitAssertionUtility'; repository: 'github://feenkcom/gtoolkit-utility/src'; load.
Metacello new baseline: 'GToolkitFileUtility'; repository: 'github://feenkcom/gtoolkit-utility/src'; load.
Metacello new baseline: 'GToolkitBasicUtility'; repository: 'github://feenkcom/gtoolkit-utility/src'; load.
Metacello new baseline: 'Bloc'; repository: 'github://feenkcom/Bloc/src'; load.
Metacello new baseline: 'BlocCore'; repository: 'github://feenkcom/Bloc/src'; load.
Metacello new baseline: 'BlocLayout'; repository: 'github://feenkcom/Bloc/src'; load.
Metacello new baseline: 'Brick'; repository: 'github://feenkcom/Brick/src'; load.
Metacello new baseline: 'GToolkitCompleter'; repository: 'github://feenkcom/gtoolkit-completer/src'; load.
Metacello new baseline: 'GToolkitPhlow'; repository: 'github://feenkcom/gtoolkit-phlow/src'; load.
Metacello new baseline: 'GToolkitPager'; repository: 'github://feenkcom/gtoolkit-pager/src'; load.
Metacello new baseline: 'GToolkitCoder'; repository: 'github://feenkcom/gtoolkit-coder/src'; load.
Metacello new baseline: 'GToolkitSpotter'; repository: 'github://feenkcom/gtoolkit-spotter/src'; load.
Metacello new baseline: 'NeoJSON'; repository: 'github://svenvc/NeoJSON:v17/repository'; load.
Metacello new baseline: 'XdocClient'; repository: 'github://feenkcom/xdoc/src'; load.
Metacello new baseline: 'XdocClientMinimal'; repository: 'github://feenkcom/xdoc/src'; load.
Metacello new baseline: 'Xdoc'; repository: 'github://feenkcom/xdoc/src'; load.
Metacello new baseline: 'GToolkitVariableBindings'; repository: 'github://feenkcom/gtoolkit-playground/src'; load.
Metacello new baseline: 'GToolkitPlayground'; repository: 'github://feenkcom/gtoolkit-playground/src'; load.
Metacello new baseline: 'GToolkitVisualizerPhlow'; repository: 'github://feenkcom/gtoolkit-visualizer/src'; load.
Metacello new baseline: 'GToolkitVisualizer'; repository: 'github://feenkcom/gtoolkit-visualizer/src'; load.
Metacello new baseline: 'GToolkitInspector'; repository: 'github://feenkcom/gtoolkit-inspector/src'; load.
Metacello new baseline: 'ContainersPropertyEnvironment'; repository: 'github://feenkcom/Containers-PropertyEnvironment:v1.0.0'; load.
Metacello new baseline: 'Chrysal'; repository: 'github://feenkcom/Chrysal:v1.0.0/src'; load.
Metacello new baseline: 'Mustache'; repository: 'github://noha/mustache:v1.0.1/repository'; load.
Metacello new baseline: 'PetitParser2Core'; repository: 'github://kursjan/petitparser2'; load.
Metacello new baseline: 'PillarExporter'; repository: 'github://feenkcom/pillar:feenk/src'; load.
Metacello new baseline: 'PillarCore'; repository: 'github://feenkcom/pillar:feenk/src'; load.
Metacello new baseline: 'DeepTraverser'; repository: 'github://feenkcom/DeepTraverser/src'; load.
Metacello new baseline: 'GToolkitDocumenter'; repository: 'github://feenkcom/gtoolkit-documenter/src'; load.
Metacello new baseline: 'GToolkitPresenter'; repository: 'github://feenkcom/gtoolkit-presenter/src'; load.
Metacello new baseline: 'GToolkitDebugger'; repository: 'github://feenkcom/gtoolkit-debugger/src'; load.
Metacello new baseline: 'GToolkitCognitiveServiceDemo'; repository: 'github://feenkcom/gtoolkit-demos/src'; load.
Metacello new baseline: 'GToolkitObjectNeuralNetworkDemo'; repository: 'github://feenkcom/gtoolkit-demos/src'; load.
Metacello new baseline: 'GToolkitWhatMakesBlocSpecialDemo'; repository: 'github://feenkcom/gtoolkit-demos/src'; load.
Metacello new baseline: 'GToolkitMoldableDevelopmentDemo'; repository: 'github://feenkcom/gtoolkit-demos/src'; load.
Metacello new baseline: 'GToolkitPharo101'; repository: 'github://feenkcom/gtoolkit-demos/src'; load.
Metacello new baseline: 'GToolkitReleaser'; repository: 'github://feenkcom/gtoolkit-releaser/src'; load.
Metacello new baseline: 'GToolkitConstrainer'; repository: 'github://feenkcom/gtoolkit-constrainer/src'; load.
Metacello new baseline: 'GToolkit4SmaCC'; repository: 'github://feenkcom/gt4smacc/src'; load.
Metacello new baseline: 'OrderPreservingDictionary'; repository: 'github://pharo-contributions/OrderPreservingDictionary:bee45d74ab513cf6230bdda2dcbaecd46905f7e6/src'; load.
Metacello new baseline: 'BitmapCharacterSet'; repository: 'github://pharo-contributions/BitmapCharacterSet:dd8c3de8fc58eab9f9a4e54a7c1f07bb2385c599/src'; load.
Metacello new baseline: 'XMLParser'; repository: 'github://feenkcom/XMLParser:v0.6.1/src'; load.
Metacello new baseline: 'XPath'; repository: 'github://feenkcom/XPath:v0.6.1/src'; load.
Metacello new baseline: 'XMLWriter'; repository: 'github://feenkcom/XMLWriter:v0.6.0/src'; load.
Metacello new baseline: 'GToolkit4XMLSupport'; repository: 'github://feenkcom/gt4xmlsupport/src'; load.
Metacello new baseline: 'GToolkit4PetitParser2'; repository: 'github://feenkcom/gt4petitparser2/src'; load.
Metacello new baseline: 'CollectionExtensions'; repository: 'github://pharo-contributions/CollectionExtensions/src'; load.
Metacello new baseline: 'Famix3SmalltalkImporter'; repository: 'github://feenkcom/famix3/src'; load.
Metacello new baseline: 'Famix3'; repository: 'github://feenkcom/famix3/src'; load.
Metacello new baseline: 'Fame'; repository: 'github://feenkcom/famix3/src'; load.
Metacello new baseline: 'GToolkit4Famix3'; repository: 'github://feenkcom/gt4famix3/src'; load.
Metacello new baseline: 'FFICHeaderExtractor'; repository: 'github://marianopeck/FFICHeaderExtractor/repository'; load.
Metacello new baseline: 'Unicode'; repository: 'github://feenkcom/pharo-unicode/repository'; load.
Metacello new baseline: 'OSSubprocess'; repository: 'github://feenkcom/OSSubprocess/repository'; load.
Metacello new baseline: 'MessagePack'; repository: 'github://msgpack/msgpack-smalltalk:v1.3.1/repository'; load.
Metacello new baseline: 'PharoLink'; repository: 'github://feenkcom/PharoLink/src'; load.
Metacello new baseline: 'GToolkitRemote'; repository: 'github://feenkcom/gtoolkit-remote/src'; load.
Metacello new baseline: 'Gt4PharoLink'; repository: 'github://feenkcom/gtoolkit-remote/src'; load.
Metacello new baseline: 'GToolkit4Git'; repository: 'github://feenkcom/gt4git/src'; load.
Metacello new baseline: 'GToolkit4Jenkins'; repository: 'github://feenkcom/gt4jenkins/src'; load.
Metacello new baseline: 'GToolkit'; repository: 'github://feenkcom/gtoolkit/src'; load.
Metacello new baseline: 'GToolkitTranscript'; repository: 'github://feenkcom/gtoolkit/src'; load.
] ensure: [ EpMonitor current enable].

PharoLightTheme beCurrent.
#GtImageSetup asClass performLocalSetup.
World closeAllWindowsDiscardingChanges.
Smalltalk snapshot: true andQuit: false.
