ui
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 0>
	| scalable |
	scalable := self "asScalableElement".
	^ self root gtInspectorLiveIn: composite