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
			package: 'GToolkit-Debugger-Pharo9' with: [
				spec requires: #(#GToolkit) ]. ].
]
