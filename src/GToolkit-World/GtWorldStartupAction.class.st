Class {
	#name : #GtWorldStartupAction,
	#superclass : #Object,
	#category : #'GToolkit-World-Utilities'
}

{ #category : #'class initialization' }
GtWorldStartupAction class >> initialize [

	SessionManager default registerSystemClassNamed: self name.
]

{ #category : #'system startup' }
GtWorldStartupAction class >> startUp: isImageStarting [
	"Only handle when lauching a new image,  not when saving the image"
	isImageStarting ifFalse: [ ^ self ].
	
	Author fullNamePerSe isEmptyOrNil ifTrue: [ 
		Author fullName: 'GlamorousAuthor' ]
]
