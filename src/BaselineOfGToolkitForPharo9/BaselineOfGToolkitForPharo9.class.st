Class {
	#name : #BaselineOfGToolkitForPharo9,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitForPharo9
}

{ #category : #baseline }
BaselineOfGToolkitForPharo9 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkit' with: [
				spec repository: 'github://feenkcom/gtoolkit:v0.8.1157/src' ].

		spec package: 'GToolkit-Pharo9-Deprecations'.
		spec package: 'GToolkit-Pharo9-Debugger' with: [
			spec requires: #('GToolkit-Pharo9-Deprecations' 'GToolkit') ].
	]
]
