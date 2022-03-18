Class {
	#name : #GtBoxerExternalObjectsShouldOnlyImplementFFILibrary,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtBoxerExternalObjectsShouldOnlyImplementFFILibrary >> description [
	^ GtBoxerExternalObject name, ' already implements ', (GtBoxerExternalObject class >> #ffiLibrary) selector printString, '. Subclasses must implement ', (GtBoxerExternalObject class >> #ffiLibrary) selector printString, ' on the class size, not on the instance side'
]

{ #category : #accessing }
GtBoxerExternalObjectsShouldOnlyImplementFFILibrary >> issues [
	"returns the facts that contradict the constraint"
	^ GtBoxerExternalObject allSubclasses
		select: [ :each |
			(each includesSelector: #ffiLibraryName)
				or: [ (each class includesSelector: #ffiLibraryName)
					or: [ each includesSelector: #ffiLibrary ] ] ]
]

{ #category : #accessing }
GtBoxerExternalObjectsShouldOnlyImplementFFILibrary >> name [
	^ 'Subclasses of ', GtBoxerExternalObject name, ' should only implement ', (GtBoxerExternalObject class >> ##ffiLibrary) selector printString, ' on the class size'
]
