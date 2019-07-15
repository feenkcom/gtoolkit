Class {
	#name : #GtTitleSlide,
	#superclass : #GtSlide,
	#instVars : [
		'title',
		'subtitle'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #'api - instantiation' }
GtTitleSlide >> create [
	^  BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout horizontal;
				addChild: (
					BlElement new
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical fitContent.
							c linear vertical alignCenter ];
						layout: BlLinearLayout vertical;
						addChild: (BlTextElement new 
							constraintsDo: [ :c |
								c linear horizontal alignCenter ];
							padding: (BlInsets top: 40; bottom: 40);
							text: title);
						addChild: (BlTextElement new 
							constraintsDo: [ :c |
								c linear horizontal alignCenter ];
							text: subtitle))
]

{ #category : #initialization }
GtTitleSlide >> initialize [
	super initialize.
	self title: ''.
	self subtitle: ''
]

{ #category : #accessing }
GtTitleSlide >> subtitle: aString [
	subtitle := aString asRopedText fontSize: 20; glamorousRegularFont
]

{ #category : #accessing }
GtTitleSlide >> subtitleText: aText [
	subtitle := aText
]

{ #category : #accessing }
GtTitleSlide >> title: aString [
	title := aString asRopedText fontSize: 30; glamorousRegularFont
]

{ #category : #accessing }
GtTitleSlide >> titleText: aText [
	title := aText
]
