Extension { #name : #Object }

{ #category : #'*GToolkit-Extensions' }
Object class >> gtMagritteDescriptionFor: aView [
	<gtClassView>
	^ aView explicit
		title: 'Magritte Descriptions';
		tooltip: 'Methods that define Magritte descriptions';
		priority: 100;
		stencil: [ (self gtMethodsInClass includeSuperclass: true)
				& #magritteDescription gtPragmas ]
]
