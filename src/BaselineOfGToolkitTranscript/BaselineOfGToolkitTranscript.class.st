"
# Transcript
This is a reimagining of the classic transcript by taking advantage of the text rendering possibilities from tha graphical stack. It offers a rich and interactive interface for displaying live information coming from a system. Text is only the beginning!
## The API
The API is backward compatible with the existing transcript. To enable the new features, we introduced a builder. For example, `transcript nextPutAll: 'something'` becomes `transcript next putAll: 'something'`. Between `next` and `putAll:`, we can add multiple attributes to the text output.

The following example shows the complete API.

{{gtExample:GtTranscriptExamples>>#completeAPI|expanded=true}}
## Logging an animation
To get an idea of how this tool could be useful, take a look at the following example. A Bloc animation is logged in a visual, domain centric way, providing insight far superior to plain text.

{{gtExample:GtTranscriptExamples>>#transcriptWitAnimation|expanded=true}}


"
Class {
	#name : #BaselineOfGToolkitTranscript,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitTranscript
}

{ #category : #baseline }
BaselineOfGToolkitTranscript >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1367/src' ].

		spec package: 'GToolkit-Transcript' with: [
			spec requires: #(#Brick) ].
	]
]
