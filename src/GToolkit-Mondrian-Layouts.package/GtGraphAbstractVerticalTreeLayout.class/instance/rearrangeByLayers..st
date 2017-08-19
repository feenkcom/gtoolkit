private
rearrangeByLayers: aGraph
	| cursor layerDepthSize |
	cursor := self topGap.
	nodesByLayer do: [:eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [:max :eachNode | 
			self translator translate: eachNode to: (eachNode position x @ cursor ).
			max max: eachNode measuredHeight ].
		cursor := cursor + layerDepthSize + self verticalGap ]