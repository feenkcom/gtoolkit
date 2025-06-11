Extension { #name : #OpalCompiler }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OpalCompiler >> isScripting: aBoolean [
	<gtPharoPatch: #Pharo>
	
	self 
		forPharo12: [ self compilationContext isScripting: aBoolean ]
		forPharo11AndPharo10: [ self noPattern: aBoolean ]
]
