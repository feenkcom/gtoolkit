"
A set of utilities to profile performance

"
Class {
	#name : #ManifestGToolkitProfiler,
	#superclass : #PackageManifest,
	#category : 'GToolkit-Profiler-Manifest'
}

{ #category : #metamodel }
ManifestGToolkitProfiler class >> processTelemetry [
"@prefix Gt
@project Profiler
@package 'GToolkit-Profiler'
@tag 'Process'
@objectTag 'Models'
@suffix Model

@derive children
@derive parent
@derive phlowList
@derive announcer
@derive notifier
@derive api
@derive print
@derive typeTest

processTelemetry(s) {
	@derive model(name: superProcessTelemetry),
	@derive add,
	@derive remove,
	items: #allSubclasses
}.

processTelemetry {
	@derive model(name: telemetry, type: BlProcessTelemetry)
}"
]

{ #category : #metamodel }
ManifestGToolkitProfiler class >> processTelemetryViewModel [
"@prefix Gt
@project Profiler
@package 'GToolkit-Profiler'
@tag 'Process'
@objectTag 'View Models'
@suffix ViewModel

@derive children
@derive parent
@derive phlowList
@derive announcer
@derive notifier
@derive api
@derive print

processTelemetry(s) => telemetryLogger => telemetrySignal(s).

processTelemetry(s) {
	@derive model(api: TGtWithProfilerProcessTelemetriesModel),
	@derive add(
		delegate: #addProfilerProcessTelemetryModel:,
		subscribe: GtProfilerProcessTelemetryModelAddedAnnouncement),
	@derive remove(
		delegate: #removeProfilerProcessTelemetryModel:,
		subscribe: GtProfilerProcessTelemetryModelRemovedAnnouncement),
	@derive selection,
	items: #profilerProcessTelemetryModels,
}.

processTelemetry {
	@derive model(api: TGtWithProfilerProcessTelemetryModel),
	@derive selection
}.

telemetryLogger {
	@derive model(name: logger),
	telemetrySignal(s): #yourself
}.

telemetrySignal(s) {
	@derive model(name: logger),
	@derive add(subscribe: BlTelemetrySignal),
	items: #recordings
}.

telemetrySignal {
	@derive model(name: signal)
}"
]
