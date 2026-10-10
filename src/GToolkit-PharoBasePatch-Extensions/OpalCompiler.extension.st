Extension { #name : #OpalCompiler }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
OpalCompiler >> isScripting: aBoolean [
	<gtPharoPatch: #Pharo>
	 
	self compilationContext isScripting: aBoolean 
]
