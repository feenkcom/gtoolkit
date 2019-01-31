Class {
	#name : #GtWorld,
	#superclass : #BlElement,
	#category : #'GToolkit-World'
}

{ #category : #'instance creation' }
GtWorld class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost new.
	aSpace title: 'GToolkit'.
	aSpace addChild: self new.
	aSpace extent: 300@500.
	aSpace show
]

{ #category : #initialization }
GtWorld >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
		
	self initializeLogo.
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Tour';
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 0);
		action: [ self openTour ]).
	
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Playground';
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 0);
		action: [ self openPlayground ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Transcript';
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 0);
		action: [ self openTranscript ]).
		
	self addChild: (BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Examples';
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 0);
		action: [ self openExamples ])
]

{ #category : #initialization }
GtWorld >> initializeLogo [
	| aText |
	
	aText := 'glamoroustoolkit' asRopedText fontSize: 30.
	(aText from: 1 to: 9) thin.
	(aText from: 10 to: aText size) bold.
	
	self addChild: (BlTextElement new
		padding: (BlInsets top: 20 bottom: 20);
		text: aText;
		constraintsDo: [ :c | c linear horizontal alignCenter ]).
]

{ #category : #'api - tools' }
GtWorld >> openExamples [
	| anExamplesExplorer aSpace |
			
	anExamplesExplorer := GtInspector createOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost new.
	aSpace title: 'Examples'.
	aSpace extent: 1200@600.
	aSpace addChild: anExamplesExplorer.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld >> openPlayground [
	| aPlayground aSpace |
			
	aPlayground := GtInspector createOnPlayBook: GtPlayBook newDefault.
	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost new.
	aSpace title: 'Playground'.
	aSpace extent: 1200@600.
	aSpace addChild: aPlayground.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld >> openTour [
	| aTour aSpace |

	aTour := GtInspector createOnPlayBook: (Gt2Document forClass: BaselineOfGToolkit).

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost new.
	aSpace title: 'Tour'.
	aSpace extent: 1200@600.
	aSpace addChild: aTour.
	aSpace show
]

{ #category : #'api - tools' }
GtWorld >> openTranscript [ 
	| aTranscriptElement aSpace |

	aTranscriptElement := GtTranscriptElement new.
	aTranscriptElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aTranscriptElement transcript: GtTranscript default.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace host: BlOSWindowHost new.
	aSpace title: 'Transcript'.
	aSpace extent: 400@600.
	aSpace addChild: aTranscriptElement.
	aSpace show
]
