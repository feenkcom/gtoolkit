Class {
	#name : #GtHashMethodsShouldReturnAValueConstraint,
	#superclass : #GtMethodShouldReturnAValueConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtHashMethodsShouldReturnAValueConstraint >> issues [
	"Temporary hack to ignore BadHasher>>#hash"
	^ super issues 
		copyWithout: BadHasher>>#hash
]

{ #category : #accessing }
GtHashMethodsShouldReturnAValueConstraint >> targetSelector [
	^ #hash
]
