Extension { #name : #MethodAdded }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
MethodAdded >> cachedNewSourceCode [
	^ cachedNewSourceCode ifNil: [
		cachedNewSourceCode := self methodAdded sourceCode ]
]
