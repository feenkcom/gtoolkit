Class {
	#name : #GtToolStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #testing }
GtToolStencil class >> isAbstract [
	^ self name = #GtToolStencil 
]

{ #category : #converting }
GtToolStencil >> asPreviewElement [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtToolStencil >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'gt-extensions' }
GtToolStencil >> gtSpotterActDefaultFrom: aSpotterElement [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: self name.
	aSpace extent: 1200@600.
	aSpace addChild: self asElement.
	aSpace withHalos.
	aSpotterElement showSpace: aSpace
]

{ #category : #accessing }
GtToolStencil >> name [
	^ self subclassResponsibility
]
