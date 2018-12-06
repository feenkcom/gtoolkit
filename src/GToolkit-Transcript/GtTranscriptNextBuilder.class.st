"
I am a utility class useful for scripting more complicated transcript instructions by cascading different options to be applied on the next string/character that is added to the transcript.

Please note that it is mandatory to end the cascade with either ==#put:-== or ==#putAll:==.

!!Example

[[[
	transcript next put: $a.
	transcript next 
		with: [ ... ];
		put: $b
]]]


"
Class {
	#name : #GtTranscriptNextBuilder,
	#superclass : #Object,
	#instVars : [
		'transcript',
		'adornmentStrategy',
		'startPosition',
		'attributes'
	],
	#category : 'GToolkit-Transcript'
}

{ #category : #private }
GtTranscriptNextBuilder >> applyAttributes [
	(transcript text
		from: self startPosition
		to: transcript text size)
			attributes: attributes
]

{ #category : #attributes }
GtTranscriptNextBuilder >> attribute: anAttribute [
	attributes add: anAttribute
]

{ #category : #attributes }
GtTranscriptNextBuilder >> attributes: aCollection [
	attributes addAll: aCollection
]

{ #category : #attributes }
GtTranscriptNextBuilder >> backgroundColor: aColor [
	self attribute: (BlTextBackgroundAttribute paint: aColor)
]

{ #category : #attributes }
GtTranscriptNextBuilder >> bold [
	self attribute: BlFontWeightAttribute bold
]

{ #category : #attributes }
GtTranscriptNextBuilder >> color: aColor [
	self attribute: (BlTextForegroundAttribute paint: aColor)
]

{ #category : #streaming }
GtTranscriptNextBuilder >> cr [
	self put: Character cr
]

{ #category : #attributes }
GtTranscriptNextBuilder >> expanded: aBlock [
	| adornmentAttribute |
	
	adornmentAttribute := BrTextAdornmentDynamicAttribute new 	
		beAppend;
		stencil: aBlock.
	
	self attributes: {
		BrTextExpandButtonAttribute new
			isExpanded: true;
			createdAttributes: { adornmentAttribute };
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					stencil: aBlock ] . 
		adornmentAttribute }
]

{ #category : #attributes }
GtTranscriptNextBuilder >> expanding: aBlock [
	self attribute: (
		BrTextExpandButtonAttribute new 
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					stencil: aBlock ])

]

{ #category : #attributes }
GtTranscriptNextBuilder >> fontSize: aNumber [
	self attribute: (BlFontSizeAttribute size: aNumber)
]

{ #category : #initialize }
GtTranscriptNextBuilder >> initialize [
	attributes := OrderedCollection new
]

{ #category : #attributes }
GtTranscriptNextBuilder >> italic [
	self attribute: BlFontItalicAttribute new
]

{ #category : #attributes }
GtTranscriptNextBuilder >> light [
	self attribute: BlFontWeightAttribute light
]

{ #category : #streaming }
GtTranscriptNextBuilder >> print: anObject [
	self putAll: anObject asString
]

{ #category : #streaming }
GtTranscriptNextBuilder >> put: aCharacter [
	self putAll: aCharacter asString
]

{ #category : #streaming }
GtTranscriptNextBuilder >> putAll: aString [

	"We should only modify the editor from within the UI thread"
	BlUniverse defer: [ 
		transcript editor inserter
			atEnd;
			string: aString asString;
			insert.

		"we delete the possible attributes inherited from the previously existing text"
		transcript text
			clearAttributes: transcript text size - aString size + 1
			to: transcript text size
			if: [ :a | true ].
		self applyAttributes ]
]

{ #category : #streaming }
GtTranscriptNextBuilder >> show: anObject [
	self print: anObject
]

{ #category : #streaming }
GtTranscriptNextBuilder >> showException: anException [
	| string |
	string := String streamContents: [ :s | 
		anException signalerContext shortDebugStackOn: s ].
	self 
		expanding: [ 
			| text |
			text := string asRopedText foreground: Color red twiceDarker.
			BrEditorElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c textFlow pushLine.
					c vertical exact: 200 ];
				background: Color white;
				border: (BlBorder paint: Color veryLightGray width: 1);
				editor: (BrTextEditor new text: text) ];
		print: anException
]

{ #category : #streaming }
GtTranscriptNextBuilder >> space [
	self put: Character space
]

{ #category : #accessing }
GtTranscriptNextBuilder >> startPosition [
	^ startPosition
]

{ #category : #streaming }
GtTranscriptNextBuilder >> streamAll: aBlock [
	| rememberedAdornmentStrategy rememberedStartPosition |
	rememberedAdornmentStrategy := adornmentStrategy.
	rememberedStartPosition := startPosition.
	aBlock value.
	adornmentStrategy := rememberedAdornmentStrategy.
	startPosition := rememberedStartPosition.
	self applyAttributes
]

{ #category : #streaming }
GtTranscriptNextBuilder >> tab [
	self put: Character tab
]

{ #category : #accessing }
GtTranscriptNextBuilder >> transcript [
	^ transcript
]

{ #category : #accessing }
GtTranscriptNextBuilder >> transcript: aTranscript [
	transcript := aTranscript.
	startPosition := transcript text size + 1
]

{ #category : #streaming }
GtTranscriptNextBuilder >> with: aBlock [
	| previewAttribute |
	previewAttribute := BrTextExpandButtonAttribute new attributesCreatingBlock: aBlock.
	attributes add: previewAttribute
]
