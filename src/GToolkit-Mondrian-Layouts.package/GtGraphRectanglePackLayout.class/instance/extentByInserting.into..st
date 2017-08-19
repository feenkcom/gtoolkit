space-calculation
extentByInserting: aRectangle into: aSpace
	| futureCorner |
	futureCorner := aSpace origin + aRectangle extent.
	
	^	(((futureCorner x - bounds x) max: 0) +
		((futureCorner y - bounds y) max: 0))
		* "this is balancing magic"
		(((futureCorner max: bounds) degrees - 45) abs / 45 + 1)
