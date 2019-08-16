Class {
	#name : #GtSlideChanged,
	#superclass : #Announcement,
	#instVars : [
		'slide'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtSlideChanged >> slide [
	^ slide
]

{ #category : #accessing }
GtSlideChanged >> slide: aSlide [
	slide := aSlide
]
