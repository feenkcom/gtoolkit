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
Object class >> gtMagritteFor: anAction [
	"We do not compute descriptions because this can be expensive
	and we want the view to be fast."

	<gtClassAction>
	self instanceHasMagritteDescription ifFalse: [ ^ anAction noAction ].

	^ anAction button
		tooltip: 'Create Magritte Form';
		icon: BrGlamorousVectorIcons playinspect;
		priority: 10;
		action: [ :aButton | aButton phlow spawnObject: self new asGtMagritteViewModel ]
]

{ #category : #'*GToolkit-Extensions' }
Object class >> instanceHasMagritteDescription [
	^ Pragma hasNamed: #magritteDescription from: self to: Object
]
