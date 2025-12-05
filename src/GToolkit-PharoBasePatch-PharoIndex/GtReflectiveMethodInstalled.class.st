Class {
	#name : #GtReflectiveMethodInstalled,
	#superclass : #Announcement,
	#instVars : [
		'oldMethod',
		'newMethod'
	],
	#category : #'GToolkit-PharoBasePatch-PharoIndex'
}

{ #category : #testing }
GtReflectiveMethodInstalled >> affectsMethod: aMethod [
	^ self newMethod == aMethod or: [ self oldMethod == aMethod ]
]

{ #category : #testing }
GtReflectiveMethodInstalled >> affectsMethodsDefinedInClass: aClass [
	^ self newMethod methodClass = aClass
		or: [ self oldMethod methodClass = aClass ]
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> newMethod [
	^ newMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> newMethod: anObject [
	newMethod := anObject
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> oldMethod [
	^ oldMethod
]

{ #category : #accessing }
GtReflectiveMethodInstalled >> oldMethod: anObject [
	oldMethod := anObject
]
