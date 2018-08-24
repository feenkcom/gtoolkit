Class {
	#name : #BaselineOfGToolkitTranscript,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGToolkitTranscript'
}

{ #category : #baseline }
BaselineOfGToolkitTranscript >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec repository: 'github://pharo-graphics/Brick/src' ];
			package: 'GToolkit-Transcript' with: [ spec requires: #(#Brick) ]
	]

]
