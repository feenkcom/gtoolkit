scripting
connectFrom: aFromBlock toAll: aToBlock
	^ self
		connect: (self topStep root mondrianNodeChildren collect: [ :each | each mondrianModel ])
		from: aFromBlock 
		toAll: aToBlock 