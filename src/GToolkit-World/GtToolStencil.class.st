Class {
	#name : #GtToolStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-World'
}

{ #category : #accessing }
GtToolStencil >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'as yet unclassified' }
GtToolStencil >> gtSpotterActDefaultFrom: aSpotterElement [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: self name.
	aSpace extent: 1200@600.
	aSpace addChild: self asElement.
	aSpace withHalos.
	aSpace withSpotter.	
	aSpotterElement showSpace: aSpace
]

{ #category : #accessing }
GtToolStencil >> name [
	^ self subclassResponsibility
]
