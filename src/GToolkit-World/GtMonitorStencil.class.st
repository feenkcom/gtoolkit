Class {
	#name : #GtMonitorStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtMonitorStencil >> create [
	^ GtInspector createOn: GtMonitor new
]

{ #category : #accessing }
GtMonitorStencil >> name [
	^ 'Monitor'
]
