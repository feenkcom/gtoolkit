scripting
connectFrom: aFromBlock to: aToBlock
	^ self
		connect: (self topStep root mondrianNodeChildren collect: [ :each | each mondrianModel ])
		from: aFromBlock 
		to: aToBlock 