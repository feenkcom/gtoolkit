scripting
connect: aCollection fromAll: aFromAllBlock to: aToBlock
	^ aCollection flatCollect: [ :each |
		self connect: (aFromAllBlock value: each) from: [ :x | x ] to: [ :x | each ] ]