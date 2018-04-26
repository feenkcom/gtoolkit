layout
onMeasure: anExtentMeasurementSpec
	"By default let layout strategy do the measuring job.
    If needed override this method to do some additional
    actions or just implement custom layout strategy"

	| aBoundingBox |
	super onMeasure: anExtentMeasurementSpec.
	aBoundingBox := self children isEmpty
		ifTrue: [ BlBounds new ]
		ifFalse: [ self children first transformation
				transformBounds: self children first measuredBounds bounds copy ].
	self children
		do: [ :aChildElement | 
			aBoundingBox
				merge: (aChildElement transformation transformBounds: aChildElement measuredBounds bounds copy) ].
	self measuredExtent: aBoundingBox extent