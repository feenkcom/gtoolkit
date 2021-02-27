Class {
	#name : #GtFileSystemStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtFileSystemStencil >> asPreviewElement [
	^ GtInspector forObject: FileLocator imageDirectory asFileReference 
]

{ #category : #'api - instantiation' }
GtFileSystemStencil >> create [
	^ (GtInspector createOn: FileLocator imageDirectory asFileReference) maximized.
]

{ #category : #accessing }
GtFileSystemStencil >> icon [
	^ BrGlamorousVectorIcons folder
]

{ #category : #accessing }
GtFileSystemStencil >> name [
	^ 'File System'
]
