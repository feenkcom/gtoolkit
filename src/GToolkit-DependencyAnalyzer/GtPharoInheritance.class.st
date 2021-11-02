Class {
	#name : #GtPharoInheritance,
	#superclass : #GtPharoAssociation,
	#instVars : [
		'superclass',
		'subclass'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'instance creation' }
GtPharoInheritance >> from [
	^ self subclass
]

{ #category : #accessing }
GtPharoInheritance >> gtDefinitionFor: aView [
	<gtView>
	^ aView explicit
		  title: 'Definition';
		  priority: 1;
		  stencil: [ (GtPharoSnippetCoder forSource: self subclass definitionString) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #printing }
GtPharoInheritance >> gtDisplayOn: stream [
	self subclass gtDisplayOn: stream.
	stream nextPutAll: ' inherits '.
	self superclass gtDisplayOn: stream.
]

{ #category : #printing }
GtPharoInheritance >> gtDisplayText [
	^  self subclass name asRopedText glamorousMonospaceBackground,
		' inherits ' asRopedText,
		self superclass name asRopedText glamorousMonospaceBackground
]

{ #category : #accessing }
GtPharoInheritance >> subclass [
	^ subclass
]

{ #category : #accessing }
GtPharoInheritance >> subclass: anObject [
	subclass := anObject
]

{ #category : #accessing }
GtPharoInheritance >> superclass [
	^ superclass
]

{ #category : #accessing }
GtPharoInheritance >> superclass: anObject [
	superclass := anObject
]

{ #category : #'instance creation' }
GtPharoInheritance >> to [
	^ self superclass
]
