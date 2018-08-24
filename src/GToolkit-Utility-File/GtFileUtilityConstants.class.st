Class {
	#name : #GtFileUtilityConstants,
	#superclass : #Object,
	#category : 'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileUtilityConstants class >> maxFileNameLenght [
	"Return a maximum file name lenght, excluding extensions and parent directories."
	^ 25
]
