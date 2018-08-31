Class {
	#name : #GtPlaygroundToolRegistryAdaptor,
	#superclass : #Object,
	#category : #'GToolkit-ToolRegistry'
}

{ #category : #initialization }
GtPlaygroundToolRegistryAdaptor class >> initialize [
	self registerToolsOn: Smalltalk tools
]

{ #category : #actions }
GtPlaygroundToolRegistryAdaptor class >> open [
	^ GtInspector openOnPlayBook
]

{ #category : #'tools registry' }
GtPlaygroundToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	"self registerToolsOn: Smalltalk tools" 
	aToolRegistry register: self as: #workspace

]

{ #category : #icons }
GtPlaygroundToolRegistryAdaptor class >> taskbarIconName [
	"Answer the icon for the receiver in a task bar."

	^ #workspaceIcon
]

{ #category : #'taskbar-required' }
GtPlaygroundToolRegistryAdaptor class >> taskbarLabel [
	^ self title
]

{ #category : #accessing }
GtPlaygroundToolRegistryAdaptor class >> title [
	^ 'GT Playground'
]
