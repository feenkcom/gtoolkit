Class {
	#name : #GtEpiceaStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtEpiceaStencil >> asPreviewElement [
	^ GtEpiceaElement new asElement
]

{ #category : #accessing }
GtEpiceaStencil >> create [
	| tool compositeTool |
	tool := GtChangePhlowTool new.
	compositeTool := GtPhlowCompositeTool new
			addTool: tool;
			addTool: (GtInspectorTool forObject: nil).
	^ (GtPager
		createOn: (GtPagerWrapperElement new
				tool: compositeTool;
				embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null)))
		maximized
]

{ #category : #accessing }
GtEpiceaStencil >> icon [
	^ BrGlamorousVectorIcons changes
]

{ #category : #accessing }
GtEpiceaStencil >> name [
	^ 'Code Changes'
]
