Extension { #name : #ZnStringEntity }

{ #category : #'*GToolkit-Extensions' }
ZnStringEntity >> gtJsonFor: aView [

	<gtView>
	self contentType main = 'application' ifFalse: [ ^ aView empty ].
	self contentType sub = 'json' ifFalse: [ ^ aView empty ].
	^ aView textEditor
		  title: 'JSON';
		  priority: 10;
		  glamorousCodeFontAndSize;
		  styler: [ JSONParser gtStyler ];
		  actionButtonIcon: BrGlamorousIcons tree asElement
		  action: [ :aButton | 
			  aButton phlow spawnObject: (STONJSON fromString: self contents) ];
		  text: [ 
			  STONJSON toStringPretty: (STONJSON fromString: self contents) ]
]
