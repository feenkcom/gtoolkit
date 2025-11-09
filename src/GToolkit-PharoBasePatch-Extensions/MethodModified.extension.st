Extension { #name : #MethodModified }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
MethodModified >> cachedNewSourceCode [
	^ cachedNewSourceCode ifNil: [
		cachedNewSourceCode := self newMethod sourceCode ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
MethodModified >> cachedOldSourceCode [
	^ cachedOldSourceCode ifNil: [
		cachedOldSourceCode := self oldMethod sourceCode]
]
