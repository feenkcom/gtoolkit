Class {
	#name : #BaselineOfGToolkitMorphic,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitMorphic
}

{ #category : #baseline }
BaselineOfGToolkitMorphic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.496/src' ].
		spec
			baseline: 'GlutinMorphic' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin:v0.8.110/src' ].

		spec package: 'GToolkit-Morphic' with: [
			spec requires: #('Bloc' 'GlutinMorphic') ].
	]
]
