Extension { #name : #OpalCompiler }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OpalCompiler >> isScripting: aBoolean [
	<gtPharoPatch: #Pharo>
	 
	self 
		forPharo12AndNewer: [ self compilationContext isScripting: aBoolean ]
		forPharo11: [ self noPattern: aBoolean ]
]
