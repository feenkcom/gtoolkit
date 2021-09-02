Class {
	#name : 'GtMonitorTool',
	#superclass : 'GtPhlowTool',
	#category : 'GToolkit-Monitor'
}

{ #category : 'api - converting' }
GtMonitorTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."

	aOneArgBlock cull: BlElement new
]

{ #category : 'api - accessing' }
GtMonitorTool >> icon [
	"Return a tool icon"
	<return: #BlElement>
	^ BrGlamorousVectorIcons largeSignal
]

{ #category : 'api - accessing' }
GtMonitorTool >> name [
	"Return a tool name"
	<return: #String or: #BlText>

	^ 'Monitor'
]
