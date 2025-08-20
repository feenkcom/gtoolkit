Class {
	#name : #LwGtSymbolTableSemaphore,
	#superclass : #Semaphore,
	#classVars : [
		'SingleInstance'
	],
	#classInstVars : [
		'enabled'
	],
	#category : #'GToolkit-PharoBasePatch-SymbolTableSemaphore-Base'
}

{ #category : #accessing }
LwGtSymbolTableSemaphore class >> disable [
	enabled := false
]

{ #category : #accessing }
LwGtSymbolTableSemaphore class >> enable [
	enabled := true
]

{ #category : #accessing }
LwGtSymbolTableSemaphore class >> enabled [
	^ enabled ifNil: [ enabled := false ]
]

{ #category : #'instance creation' }
LwGtSymbolTableSemaphore class >> singleInstance [
	^ SingleInstance ifNil: [ SingleInstance := self forMutualExclusion ]
]
