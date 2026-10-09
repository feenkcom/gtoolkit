Extension { #name : #RBCondition }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBCondition class >> hasSubclasses: aClass excluding: classList [
	<gtPharoPatch: #Pharo12>
	^self new
		block: [ ((aClass subclasses collect: [:each | each name]) copyWithoutAll: classList) isNotEmpty ]
		errorString: aClass printString , ' has <1?:no >subclasses'
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBCondition class >> isEmptyClass: anObject [
	<gtPharoPatch: #Pharo12>
	^ self new
		  block: [
			  anObject classVariableNames isEmpty and: [
				  anObject instanceVariableNames isEmpty and: [
					  anObject selectors isEmpty ] ] ]
		  errorString: anObject printString , ' is <1?:not > empty'
]
