private
examplesDo: aBlock
	self exampleMethodsDo: [ :method |
		self exampleFromMethod: method do: aBlock ]