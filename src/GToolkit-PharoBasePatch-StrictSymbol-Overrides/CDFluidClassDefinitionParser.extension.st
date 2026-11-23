Extension { #name : #CDFluidClassDefinitionParser }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
CDFluidClassDefinitionParser >> handleSharedVariabeNode: variableDefNode [
	"Message selectors are Symbols"
	<gtPharoPatch: #StrictComparison>
	 | variable |

	"when a class variable is just #ClassVars"
	variableDefNode isLiteralNode ifTrue: [ ^ classDefinition addSharedVariable: (self handleSharedVarableNodeSimple: variableDefNode)].

	"Setting, default off, to allow experiments"
	self class unrestrictedVariableDefinitions ifTrue: [
		^ classDefinition addSharedVariable: (self handleUnrestrictedSharedVariableDefinition: variableDefNode) ].

	"#ClassVar => SomeVar default: 5; default2: 4"
	variableDefNode isCascade ifTrue: [ variable := self handleSharedVariableNodeCascade: variableDefNode].
	"when a class var is just #var => SomeVar"
	(variableDefNode isMessage and: [ variableDefNode selector = #'=>'  ])ifTrue: [  variable := self handleSharedVariableNodeSimpleClass: variableDefNode].
	"When a class variable is #Var => SomeVar default: 5"
	(variableDefNode isMessage and: [ variableDefNode selector ~= #'=>'  ]) ifTrue:  [ variable := self handleSharedVariableNodeSimpleClassArgument: variableDefNode].

	variable ifNil: [ ^self error: 'Variable definion can not be parsed' ].
	classDefinition addSharedVariable: variable
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
CDFluidClassDefinitionParser >> handleSlotNode: slotDefNode [
	"Message selectors are Symbols"
	<gtPharoPatch: #StrictComparison>
	 | slot |

	"when a slot is just #inst"
	slotDefNode isLiteralNode ifTrue: [
		^ classDefinition addSlot: ( self handleSlotNodeSimple: slotDefNode)].

	"Setting, default off, to allow experiments"
	self class unrestrictedVariableDefinitions ifTrue: [
		^ classDefinition addSlot: (self handleUnrestrictedSlotDefinition: slotDefNode) ].

	"#inst => InstanceVariableSlot default: 5; default2: 4"
	slotDefNode isCascade ifTrue: [ slot := self handleSlotNodeCascade: slotDefNode].
	"when a slot is just #inst => InstanceVariableSlot."
	(slotDefNode isMessage and: [ slotDefNode selector = #'=>'  ])ifTrue: [  slot := self handleSlotNodeSimpleClass: slotDefNode].
	"when a slot is #inst => InstanceVariableSlot default: 5."
	(slotDefNode isMessage and: [ slotDefNode selector ~= #'=>'  ]) ifTrue:  [ slot := self handleSlotNodeSimpleClassArgument: slotDefNode].

	slot ifNil: [ ^self error: 'Slot definion can not be parsed' ].
	classDefinition addSlot: slot
]
