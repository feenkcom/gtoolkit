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
	^ GtInspector createOn: GtMonitor new
]

{ #category : #accessing }
GtMonitorStencil >> name [
	^ 'Monitor'
]
