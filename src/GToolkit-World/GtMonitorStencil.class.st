Class {
	#name : #GtMonitorStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #'api - instantiation' }
GtMonitorStencil >> create [
	^ Gt2Inspector createOn: GtMonitor new
]

{ #category : #accessing }
GtMonitorStencil >> name [
	^ 'Monitor'
]
