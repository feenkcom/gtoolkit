Class {
	#name : #GtBlocEventsShouldHaveDispatchMethodSimilarToClass,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtBlocEventsShouldHaveDispatchMethodSimilarToClass >> dispatchMethodNameFor: anEventClass prefix: aClassPrefix [
	<return: #String>
	
	^ (anEventClass name gtRemovePrefix: aClassPrefix) uncapitalized asSymbol asMutator
]

{ #category : #accessing }
GtBlocEventsShouldHaveDispatchMethodSimilarToClass >> issues [
	| eventsWithSendTo |

	eventsWithSendTo := BlEvent allSubclasses select: [ :eachEventClass |
		(eachEventClass package name = 'Bloc')
			and: [ eachEventClass includesSelector: #sendTo: ] ].

	^ eventsWithSendTo reject: [ :echEventClass |
		| aMethodName aMatcher |
		
		aMethodName := self dispatchMethodNameFor: echEventClass prefix: 'Bl'.
		aMatcher := RBParser parseRewriteMethod: ('sendTo: `var
			`var {1} self' format: { aMethodName }).
	
		aMatcher
			match: (echEventClass >> #sendTo:) ast
			inContext: Dictionary new ]
]

{ #category : #accessing }
GtBlocEventsShouldHaveDispatchMethodSimilarToClass >> name [
	^ 'Dispatch method in BlEvent>>#sendTo: should be similar to the event class'
]
