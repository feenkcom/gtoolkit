hook
doExecute: nodeElements

	| rootNodes xOffset maximumRadius | 
	initialLayout isNil
		ifFalse: [ initialLayout new executeOnElements: nodeElements ].
	rootNodes := self rootNodesFor: nodeElements.
	rootNodes
		do: [ :e | self initialize: e whoseFatherIs: nil ];
		do: [ :e | self computePosition: e. self step];
		do: [ :e | self computeGap: e ];
		do: [ :e | self toRadialTree: e withMod: 0 ].
	xOffset := 0.
	rootNodes
		do: [ :e | 
			maximumRadius := self radialDraw: e.
			"Shifting all the subgroups"
			self shiftTree: e by:  (maximumRadius+xOffset)@maximumRadius.
			xOffset := xOffset + (2 * maximumRadius) + 10.  ].

