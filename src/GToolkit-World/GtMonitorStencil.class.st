Class {
	#name : #GtMonitorStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtMonitorStencil >> asPreviewElement [
	^ GtInspector newOn: GtMonitor new
]

{ #category : #'api - instantiation' }
GtMonitorStencil >> create [
	^ (GtInspector createOn: GtMonitor new) maximized
]

{ #category : #accessing }
GtMonitorStencil >> icon [
	^ BrGlamorousVectorIcons emphasizedInspect
]

{ #category : #accessing }
GtMonitorStencil >> name [
	^ 'Monitor'
]
