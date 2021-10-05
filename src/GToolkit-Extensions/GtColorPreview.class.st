"
I preview colors.
I am used by {{gtMethod:GtSpotterStart>>#spotterForColorFor:}}.

#Example
{{gtExample:GtColorPreview class>>#grayColor|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : #GtColorPreview,
	#superclass : #Object,
	#instVars : [
		'name',
		'color'
	],
	#category : 'GToolkit-Extensions'
}

{ #category : #examples }
GtColorPreview class >> grayColor [
	<gtExample>
	^ self new
		color: Color gray;
		name: #gray
]

{ #category : #comparing }
GtColorPreview >> < anObject [
	^ self color red < anObject color red and: [ 
		self color green < anObject color green and: [ 
			self color blue < anObject color blue ] ]
]

{ #category : #comparing }
GtColorPreview >> = anObject [
	^ self class = anObject class and: [ 
		self name = anObject name and: [ 
			self color = anObject color ] ]
]

{ #category : #converting }
GtColorPreview >> asElement [
	<return: #BlElement>
	^ BrVerticalPane new matchParent
		addChild: self newEditorAndClipboardElement;
		addChild: self newColorPreviewElement;
		margin: (BlInsets all: 5)
]

{ #category : #accessing }
GtColorPreview >> color [
	^ color
]

{ #category : #accessing }
GtColorPreview >> color: anObject [
	color := anObject
]

{ #category : #'gt extensions' }
GtColorPreview >> gtDetailFor: aView [
	<gtView>
	self color ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Detail';
		priority: 2;
		object: [ self color ];
		view: #gtPreviewFor:
]

{ #category : #'gt extensions' }
GtColorPreview >> gtPreviewFor: aView [
	<gtView>
	self color ifNil: [ ^ aView empty ].
	self name ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ self ]
]

{ #category : #comparing }
GtColorPreview >> hash [
	^ (self class hash 
		bitXor: self name hash)
			bitXor: self color hash
]

{ #category : #accessing }
GtColorPreview >> name [
	^ name
]

{ #category : #accessing }
GtColorPreview >> name: anObject [
	name := anObject
]

{ #category : #'instance creation' }
GtColorPreview >> newClipboardElement [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons clipboard;
		label: 'Copy to clipboard' translated;
		action: [ :aButton | 
			Clipboard clipboardText: self newColorCreationCode. ];
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'instance creation' }
GtColorPreview >> newCodeEditor [
	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude;
		beReadOnlyWithSelection;
		background: Color white;
		margin: (BlInsets all: 5);
		vFitContent;
		hFitContent;
		text: self newColorCreationCode;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'instance creation' }
GtColorPreview >> newColorCreationCode [
	<return: #String>
	^ Color name, ' ', self name
]

{ #category : #'instance creation' }
GtColorPreview >> newColorPreviewElement [
	^ BlElement new 
		margin: (BlInsets all: 5);
		background: self color; 
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ]
]

{ #category : #'instance creation' }
GtColorPreview >> newEditorAndClipboardElement [
	^ BrHorizontalPane new fitContent
		addChild: self newCodeEditor;
		addChild: self newClipboardElement;
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #printing }
GtColorPreview >> printOn: aStream [
	self name ifNil: [ 
		super printOn: aStream.
		^ self ].
	aStream print: self color
]
