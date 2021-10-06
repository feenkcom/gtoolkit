"
I exist to prevent opening of Morphic World when there is a default GtWorld opened
"
Class {
	#name : #GtNullWorldMorphicRenderer,
	#superclass : #NullWorldRenderer,
	#classVars : [
		'isEnabled'
	],
	#category : 'GToolkit-World-UI'
}

{ #category : #protocol }
GtNullWorldMorphicRenderer class >> disable [
	isEnabled := false
]

{ #category : #protocol }
GtNullWorldMorphicRenderer class >> enable [
	isEnabled := true
]

{ #category : #accessing }
GtNullWorldMorphicRenderer class >> initialize [
	isEnabled := true
]

{ #category : #accessing }
GtNullWorldMorphicRenderer class >> isApplicableFor: aWorld [
	<return: #Boolean>

	(isEnabled isNotNil and: [ isEnabled not ])
		ifTrue: [ ^ false ].

	(Smalltalk isHeadless and: [ (CommandLineArguments new hasOption: 'interactive') ])
		ifFalse: [ ^ false ].

	GtWorld defaultId
		ifNil: [ ^ false ].

 	GtWorld
		spaceWithId: GtWorld defaultId 
		do: [ :aSpace | ^ aSpace isOpened ].

	^ false
]

{ #category : #accessing }
GtNullWorldMorphicRenderer class >> priority [ 
	^ 100
]
