"
I am a utility class useful for scripting more complicated transcript instructions by cascading different options to be applied on the next string/character that is added to the transcript.

Please note that it is mandatory to end the cascade with either `#put:-` or `#putAll:`.

## Example

```
	transcript next put: $a.
	transcript next 
		with: [ ... ];
		put: $b
```


"
Class {
	#name : #GtTranscriptNextBuilder,
	#superclass : #Object,
	#instVars : [
		'transcript',
		'adornmentStrategy',
		'attributes',
		'adornments'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #attributes }
GtTranscriptNextBuilder >> adornment: anAdornment [
	adornments add: anAdornment 
]

{ #category : #attributes }
GtTranscriptNextBuilder >> adornments: aCollection [
	adornments addAll: aCollection
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
	
	self adornments: {
		BrGlamorousTriangleExpanderTextAttribute new
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
	self adornment: (
		BrGlamorousTriangleExpanderTextAttribute new 
			attributesCreatingBlock: [
				BrTextAdornmentDynamicAttribute new 	
					beAppend;
					stencil: aBlock ])

]

{ #category : #attributes }
GtTranscriptNextBuilder >> fontSize: aNumber [
	self attribute: (BlFontSizeAttribute size: aNumber)
]

{ #category : #attributes }
GtTranscriptNextBuilder >> foreground: aColor [
	self attribute: (BlTextForegroundAttribute paint: aColor)
]

{ #category : #initialize }
GtTranscriptNextBuilder >> initialize [
	attributes := OrderedCollection with: (BlFontFamilyAttribute named: 'Source Code Pro').
	adornments := OrderedCollection new
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

	transcript
		insertString: aString
		withAttributesForWholeString: attributes
		withAttributesAtTheEnd: adornments
]

{ #category : #streaming }
GtTranscriptNextBuilder >> show: anObject [
	self print: anObject
]

{ #category : #streaming }
GtTranscriptNextBuilder >> showException: anException [
	| stack |
	
	stack := anException signalerContext stack.

	self 
		expanding: [ 
			| button list card |
			button := anException asDebuggableElement vFitContent.
			list := (GtPhlowView empty list items: stack) asElementDo: #yourself.
			card := list asVerticallyResizableDo: [ :aContainer |
				aContainer addChild: button at: 1.
				aContainer layout: BlLinearLayout vertical.
				aContainer padding: (BlInsets all: 10).
				aContainer constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 200 ] ].
			card addAptitude: GtPreviewAptitude new.
			card ];
		print: anException
]

{ #category : #streaming }
GtTranscriptNextBuilder >> showObject: anObject [
	self
		expanding: [ (anObject gtViewsFor: GtPhlowEmptyView new)
				asElementDo: [ :e | 
					e
						asVerticallyResizableDo: [ :aContainer | 
							aContainer margin: (BlInsets all: 10).
							aContainer layout: BlLinearLayout vertical.
							aContainer
								constraintsDo: [ :c | 
									c horizontal matchParent.
									c vertical exact: 200 ].
							aContainer addAptitude: GtPreviewAptitude new.
							aContainer ] ] ];
		print: anObject gtDisplayString
]

{ #category : #streaming }
GtTranscriptNextBuilder >> space [
	self put: Character space
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
	transcript := aTranscript
]

{ #category : #streaming }
GtTranscriptNextBuilder >> with: aBlock [
	| previewAttribute |
	previewAttribute := BrGlamorousTriangleExpanderTextAttribute new attributesCreatingBlock: aBlock.
	attributes add: previewAttribute
]
