scripting
connect: aCollection fromAll: aFromAllBlock to: aToBlock
	aCollection do: [ :each |
		self connect: (aFromAllBlock value: each) from: [ :x | x ] to: [ :x | each ] ]