reversing
inverseAttachPoint
	"Invert the attach point of all the considered edges. It is likely that all the attachpoint are the same, but we do not have a garanty"
	self shouldSetDefaultAttachPoint ifFalse: [ ^ self ].
	edges
		do: [ :edge |
			self flag: 'Attach point'.
			 
			"edge shape attachPoint inverted: true.
			edge updateFromTo" ]