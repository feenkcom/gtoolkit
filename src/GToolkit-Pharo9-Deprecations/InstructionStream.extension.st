Extension { #name : #InstructionStream }

{ #category : #'*GToolkit-Pharo9-Deprecations' }
InstructionStream >> nextInstruction [
	"Return the next bytecode instruction as a message that an InstructionClient would understand.  This advances the pc by one instruction."

	^ self interpretNextInstructionFor: MessageCatcher new
]
