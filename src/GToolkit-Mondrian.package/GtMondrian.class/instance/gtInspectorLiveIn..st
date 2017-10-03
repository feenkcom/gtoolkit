ui
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 0>
	| scalable |
	scalable := self asScalableElement.
	^ scalable gtInspectorLiveIn: composite