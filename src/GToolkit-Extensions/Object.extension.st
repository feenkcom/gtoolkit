Extension { #name : #Object }

{ #category : #'*GToolkit-Extensions' }
Object class >> gtMagritteDescriptionFor: aView [
	<gtClassView>
	self instanceHasMagritteDescription ifFalse: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Magritte Descriptions';
		tooltip: 'Methods that define Magritte descriptions';
		priority: 100;
		stencil: [ (self gtMethodsInClass includeSuperclass: true)
				& #magritteDescription gtPragmas ]
]

{ #category : #'*GToolkit-Extensions' }
Object class >> instanceHasMagritteDescription [
	^ Pragma hasNamed: #magritteDescription from: self to: Object
]
