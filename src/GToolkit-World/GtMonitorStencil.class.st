Class {
	#name : #GtMonitorStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtMonitorStencil >> asPreviewElement [
	^ Gt2Inspector newOn: GtMonitor new
]

{ #category : #'api - instantiation' }
GtMonitorStencil >> create [
	^ Gt2Inspector createOn: GtMonitor new
]

{ #category : #accessing }
GtMonitorStencil >> name [
	^ 'Monitor'
]
