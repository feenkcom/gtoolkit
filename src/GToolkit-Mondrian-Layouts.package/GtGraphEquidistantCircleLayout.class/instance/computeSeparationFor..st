hook
computeSeparationFor: elements
"Compute the separation between each element, this separation will always be the same"
	| sep |
	sep := ((2 * Float pi * (self computeRadiusFor: elements)) - (self weightSum: elements))/
	(elements size).
	^sep