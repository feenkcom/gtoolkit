Extension { #name : #RBAddMethodRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddMethodRefactoring class >> addMethod: aString toClass: aClass inProtocols: protocolList [
	<gtPharoPatch: #Pharo>
	
	^ self
		forPharo12AndNewer: [ 
			self
				sourceCode: aString
				in: aClass
				withProtocol: (protocolList at: 1 ifAbsent: [ #accessing ]) ]
		forPharo11: [ 
			self new
				addMethod: aString
				toClass: aClass
				inProtocols: protocolList ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBAddMethodRefactoring class >> model: aRBSmalltalk addMethod: aString toClass: aClass inProtocols: protocolList [
	<gtPharoPatch: #Pharo>
	^ self
		forPharo12AndNewer: [ self
				model: aRBSmalltalk
				sourceCode: aString
				in: aClass
				withProtocol: (protocolList at: 1 ifAbsent: [ #accessing ]) ]
		forPharo11: [ ^ self new
				model: aRBSmalltalk;
				addMethod: aString
					toClass: aClass
					inProtocols: protocolList;
				yourself ]
]
