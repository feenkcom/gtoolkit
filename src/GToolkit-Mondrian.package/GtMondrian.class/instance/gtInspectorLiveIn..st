ui
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 0>
	| scalable |
	
	scalable := BlScalableElement new.
	scalable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scalable contentElement: self topStep root.

	^ scalable gtInspectorLiveIn: composite