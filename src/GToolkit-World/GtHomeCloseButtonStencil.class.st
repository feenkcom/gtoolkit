Class {
	#name : #GtHomeCloseButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'closeAction'
	],
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtHomeCloseButtonStencil >> closeAction [
	^ closeAction
]

{ #category : #accessing }
GtHomeCloseButtonStencil >> closeAction: aBlock [
	closeAction := aBlock
]

{ #category : #accessing }
GtHomeCloseButtonStencil >> create [
	^ GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorPlusIconStencil close asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c
				margin:
					(BlInsets
						top: -10
						left: 0
						bottom: 0
						right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: self closeAction
]
