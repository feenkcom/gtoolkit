Extension { #name : #GtNotificationIcebergCredentialsSignal }

{ #category : #'*GToolkit-Extensions' }
GtNotificationIcebergCredentialsSignal >> gtStackFor: aView [
	<gtView>
	^ aView explicit
		title: 'Stack';
		priority: 10;
		stencil: [ (GtPharoMethodsCoder forItems: (self context collect: #method)) ]
]
