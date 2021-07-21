Class {
	#name : #BaselineOfGToolkitForPharo9,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitForPharo9
}

{ #category : #baselines }
BaselineOfGToolkitForPharo9 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GToolkit' with: [ spec repository: 'github://feenkcom/gtoolkit/src' ].
		spec 
			package: 'GToolkit-Pharo9-Deprecations';
			package: 'GToolkit-Debugger-Pharo9' with: [
				spec requires: #('GToolkit-Pharo9-Deprecations' 'GToolkit') ]. ].
]
