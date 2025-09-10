Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
RBProgramNode >> isUsed [
	<gtPharoPatch: #Pharo>
	"Answer true if this node could be used as part of another expression. For example, you could use the
	result of this node as a receiver of a message, an argument, the right part of an assignment, or the
	return value of a block. This differs from isDirectlyUsed in that it is conservative since it also includes
	return values of blocks."

	^ self 
		forPharo12AndNewer: [ self isUsedAsReturnValue ] 
		forPharo11: [
			parent ifNil: [false] ifNotNil: [parent uses: self] ]
]
