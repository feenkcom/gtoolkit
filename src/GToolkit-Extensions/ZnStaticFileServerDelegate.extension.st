Extension { #name : #ZnStaticFileServerDelegate }

{ #category : #'*GToolkit-Extensions' }
ZnStaticFileServerDelegate >> gtDirectoryFor: aView [
	<gtView>
	self directory ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Directory';
		priority: 15;
		object: [ self directory ];
		view: #gtTreeFor:
]
