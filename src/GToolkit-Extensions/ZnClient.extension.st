Extension { #name : #ZnClient }

{ #category : #'*GToolkit-Extensions' }
ZnClient >> gtCurlFor: aView [
	<gtView>
	
	self request ifNil: [ ^ aView empty ].
	self request requestLine ifNil: [ ^ aView empty ].
	self request method ifNil: [ ^ aView empty ].
	self request uri ifNil: [ ^ aView empty ].
	
	^ aView textEditor
		title: 'CURL';
		priority: 40;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		text: [ [ self curl ] on: Error do: [ :anException | 
			'Client is not initialized yet: ', anException displayString  ] ]
]
