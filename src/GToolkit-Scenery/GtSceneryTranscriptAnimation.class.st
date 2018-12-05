Class {
	#name : #GtSceneryTranscriptAnimation,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTranscriptAnimation class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 905.0; 
		parent: #GToolkitScenery;
		label: 'Transcript: Animation';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTranscriptAnimation >> setUp [
	GtInspector openOn: (GtTranscriptExamples>>#transcriptWitAnimation) gtExample
]
