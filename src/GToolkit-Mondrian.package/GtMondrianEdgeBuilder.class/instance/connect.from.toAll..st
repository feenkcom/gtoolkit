scripting
connect: aCollection from: aFromBlock toAll: aToAllBlock
	^ aCollection flatCollect: [ :each |
		self connect: (aToAllBlock value: each) from: [ :x | each ] to: [ :x | x ] ]