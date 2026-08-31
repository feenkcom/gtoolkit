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
				spec repository: 'github://feenkcom/Bloc:v0.9.101/src' ].
		spec
			baseline: 'WinitMorphic' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin:v0.8.162/src' ].

		spec package: 'GToolkit-Morphic' with: [
			spec requires: #(#Bloc #WinitMorphic) ].
	]
]
