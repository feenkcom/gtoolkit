Class {
	#name : #GtInspectorToolRegistryAdaptor,
	#superclass : #Object,
	#category : #'GToolkit-ToolRegistry'
}

{ #category : #initialization }
GtInspectorToolRegistryAdaptor class >> initialize [
	self registerToolsOn: Smalltalk tools
]

{ #category : #actions }
GtInspectorToolRegistryAdaptor class >> inspect: anObject [ 
	^ GtInspector openOn: anObject
]

{ #category : #'tools registry' }
GtInspectorToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	"self registerToolsOn: Smalltalk tools" 
	aToolRegistry register: self as: #inspector

]
