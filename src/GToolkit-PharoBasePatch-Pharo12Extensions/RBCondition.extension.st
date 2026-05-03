Extension { #name : #RBCondition }

{ #category : #'*GToolkit-PharoBasePatch-Pharo12Extensions' }
RBCondition >> violationMessageOn: aStream [
	aStream nextPutAll: self errorString
]
