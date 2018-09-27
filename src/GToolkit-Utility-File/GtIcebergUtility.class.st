Class {
	#name : #GtIcebergUtility,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtIcebergUtility class >> repositoriesLocation [
	"Return an Iceberg repositories location. 
	It is a local disk location where source code repositories take place"
	<return: #FileReference>
	SystemVersion current major = 6 ifTrue: [ ^ IceRepository repositoriesLocation ].
	^ (self environment at: #IceLibgitRepository) repositoriesLocation
]
