private
moveAllElementsToTopLeft: elements

	| pos min |
	pos := elements collect: #position.
	min := pos inject: 0 @ 0 into: [ :minimum :p | minimum min: p ].
	elements do: [ :e | e position: e position + min negated ] 