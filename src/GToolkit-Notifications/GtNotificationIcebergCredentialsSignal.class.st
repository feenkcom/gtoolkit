Class {
	#name : #GtNotificationIcebergCredentialsSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'context',
		'credentials',
		'uiContexts'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'GToolkit-Notifications-Iceberg'
}

{ #category : #'private - accessing' }
GtNotificationIcebergCredentialsSignal class >> blocContexts [
	^ BlParallelUniverse all 
			collect: [ :eachUniverse |
				| aResult |
				eachUniverse hostClass
					uiProcessDo: [ :eachUIProcess |
						aResult := eachUIProcess suspendedContext ifNil: [ thisContext ] ].
				aResult ]
]

{ #category : #'api - enable / disable' }
GtNotificationIcebergCredentialsSignal class >> disable [
	Enabled := false
]

{ #category : #'api - emitting' }
GtNotificationIcebergCredentialsSignal class >> emitOnProvider: aProvider credentials: aCredentials [
	self new
		context: thisContext stack;
		credentials: aCredentials;
		uiContexts: self blocContexts;
		emit.
]

{ #category : #'api - enable / disable' }
GtNotificationIcebergCredentialsSignal class >> enable [
	Enabled := true
]

{ #category : #'api - enable / disable' }
GtNotificationIcebergCredentialsSignal class >> isEnabled [
	^ Enabled ifNil: [ Enabled := false ]
]

{ #category : #'api - emitting' }
GtNotificationIcebergCredentialsSignal class >> mayEmitOnProvider: aProvider credentials: aCredentials [
	self isEnabled ifFalse: [ ^ self ].
	self emitOnProvider: aProvider credentials: aCredentials.
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> context [
	^ context
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> context: anObject [
	context := anObject
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> credentials [
	^ credentials
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> credentials: anObject [
	credentials := anObject
]

{ #category : #'gt-extensions' }
GtNotificationIcebergCredentialsSignal >> gtStackContextFor: aView [
	<gtView>
	^ aView list
		title: 'Context';
		priority: 14;
		items: [ self context ]
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> gtStackFor: aView [
	<gtView>
	^ aView explicit
		title: 'Stack';
		priority: 10;
		stencil: [ (GtMethodsCoder forItems: (self context collect: #method)) ]
]

{ #category : #'gt-extensions' }
GtNotificationIcebergCredentialsSignal >> gtUIContextsFor: aView [
	<gtView>
	^ aView list
		title: 'UI Contexts';
		priority: 16;
		items: [ self uiContexts ifNil: [ #() ] ]
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> uiContexts [
	^ uiContexts
]

{ #category : #accessing }
GtNotificationIcebergCredentialsSignal >> uiContexts: anObject [
	uiContexts := anObject
]
