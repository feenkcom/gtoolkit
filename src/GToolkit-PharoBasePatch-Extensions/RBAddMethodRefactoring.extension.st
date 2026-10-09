Extension { #name : #RBAddMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddMethodRefactoring class >> addMethod: aString toClass: aClass inProtocols: protocolList [
	<gtPharoPatch: #Pharo>
	
	^ self
			sourceCode: aString
			in: aClass
			withProtocol: (protocolList at: 1 ifAbsent: [ #accessing ]) 
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddMethodRefactoring class >> model: aRBSmalltalk addMethod: aString toClass: aClass inProtocols: protocolList [
	<gtPharoPatch: #Pharo>
	^ self
			model: aRBSmalltalk
			sourceCode: aString
			in: aClass
			withProtocol: (protocolList at: 1 ifAbsent: [ #accessing ]) 
]
