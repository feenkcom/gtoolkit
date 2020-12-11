Class {
	#name : #BaselineOfGToolkitMorphic,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitMorphic
}

{ #category : #baseline }
BaselineOfGToolkitMorphic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		"Morphic host to be able to render Bloc in morphic windows"
		spec 
			baseline: 'BlocMorphic' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].

		"Being able to render Morphic world in a glutin window"
		spec 
			baseline: 'GlutinMorphic' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin/src' ].
		
		"some glue code that connects the pieces"
		spec
			package: #'GToolkit-Morphic' with: [ spec requires: [ #(BlocMorphic) ] ] ]
]
