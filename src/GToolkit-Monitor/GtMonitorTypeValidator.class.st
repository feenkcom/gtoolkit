Class {
	#name : #GtMonitorTypeValidator,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #installation }
GtMonitorTypeValidator class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #installation }
GtMonitorTypeValidator class >> install [
	self default
		uninstall;
		install
]

{ #category : #installation }
GtMonitorTypeValidator class >> isInstalled [
	^ self default isInstalled
]

{ #category : #installation }
GtMonitorTypeValidator class >> uninstall [
	self default uninstall
]

{ #category : #installation }
GtMonitorTypeValidator >> install [
	self subclassResponsibility
]

{ #category : #installation }
GtMonitorTypeValidator >> isInstalled [
	^ self subclassResponsibility
]

{ #category : #installation }
GtMonitorTypeValidator >> uninstall [
	self subclassResponsibility
]
