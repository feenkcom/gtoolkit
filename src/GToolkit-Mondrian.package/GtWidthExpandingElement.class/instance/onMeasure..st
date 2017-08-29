layout
onMeasure: anExtentMeasurementSpec
	| maxWidth |
	
	super onMeasure: anExtentMeasurementSpec.
	
	maxWidth := self children inject: 0 into: [ :max :aChild | aChild measuredWidth max: max ].
	
	self childrenDo: [ :aChild |		
			aChild measure: (BlExtentMeasurementSpec exact: maxWidth @ aChild measuredHeight)
	]