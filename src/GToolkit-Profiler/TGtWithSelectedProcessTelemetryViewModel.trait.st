Trait {
	#name : #TGtWithSelectedProcessTelemetryViewModel,
	#instVars : [
		'selectedProcessTelemetryViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Support'
}

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> deselectProcessTelemetryViewModel [
	<propertyUnsetter: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousSelectedProcessTelemetryViewModel |

	self hasSelectedProcessTelemetryViewModel
		ifFalse: [ ^ self ].

	aPreviousSelectedProcessTelemetryViewModel := selectedProcessTelemetryViewModel.
	selectedProcessTelemetryViewModel := nil.
	self onPreviousSelectedProcessTelemetryViewModelUnset: aPreviousSelectedProcessTelemetryViewModel.
	self notifySelectedProcessTelemetryViewModelChanged
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> hasSelectedProcessTelemetryViewModel [
	<return: #Boolean>
	<propertyTester: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ selectedProcessTelemetryViewModel notNil
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> notifySelectedProcessTelemetryViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> onNewSelectedProcessTelemetryViewModelSet: aNewSelectedProcessTelemetryViewModel [
	"Is sent after a new value of the selectedProcessTelemetryViewModel is assigned"
	<propertySetHook: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> onPreviousSelectedProcessTelemetryViewModelUnset: aPreviousSelectedProcessTelemetryViewModel [
	"Is sent after a previous value of the selectedProcessTelemetryViewModel is de-assigned"
	<propertyUnsetHook: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> selectProcessTelemetryViewModel: aNewSelectedProcessTelemetryViewModel [
	<propertySetter: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasSelectedProcessTelemetryViewModel
		and: [ self selectedProcessTelemetryViewModel = aNewSelectedProcessTelemetryViewModel ])
			ifTrue: [ ^ self ].
	
	self hasSelectedProcessTelemetryViewModel
		ifTrue: [
			| aPreviousSelectedProcessTelemetryViewModel |
			aPreviousSelectedProcessTelemetryViewModel := selectedProcessTelemetryViewModel.
			selectedProcessTelemetryViewModel := nil.
			self onPreviousSelectedProcessTelemetryViewModelUnset: aPreviousSelectedProcessTelemetryViewModel ].
	selectedProcessTelemetryViewModel := aNewSelectedProcessTelemetryViewModel.
	self onNewSelectedProcessTelemetryViewModelSet: aNewSelectedProcessTelemetryViewModel.
	self notifySelectedProcessTelemetryViewModelChanged
]

{ #category : #'api - selected process telemetry view model' }
TGtWithSelectedProcessTelemetryViewModel >> selectedProcessTelemetryViewModel [
	<return: #GtProfilerProcessTelemetryViewModel>
	<propertyGetter: #selectedProcessTelemetryViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ selectedProcessTelemetryViewModel
]
