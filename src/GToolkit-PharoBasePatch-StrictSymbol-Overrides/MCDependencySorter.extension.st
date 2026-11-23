Extension { #name : #MCDependencySorter }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCDependencySorter >> addProvision: anObject [
	"Provisions and requirements are names, as Strings or Symbols (e.g. pool dictionary names): key them by Symbols"
	<gtPharoPatch: #StrictComparison>
	| aKey newlySatisfied |
	aKey := anObject isString ifTrue: [ anObject asSymbol ] ifFalse: [ anObject ].
	provided add: aKey.
	newlySatisfied := required removeKey: aKey ifAbsent: [#()].
	self addAll: newlySatisfied.
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCDependencySorter >> externalRequirements [
	"The requirements are keyed by Symbols (see addProvision:)"
	<gtPharoPatch: #StrictComparison>
	| unloaded providedByUnloaded |
	unloaded := self itemsWithMissingRequirements.
	providedByUnloaded := (unloaded flatCollect: [:e | e provisions collect: [ :each | each isString ifTrue: [ each asSymbol ] ifFalse: [ each ] ] ]) asSet.
	^ required keys reject: [:ea | providedByUnloaded includes: ea ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCDependencySorter >> itemsRequiring: anObject [
	"Requirements are keyed by Symbols (see addProvision:)"
	<gtPharoPatch: #StrictComparison>
	^ required at: (anObject isString ifTrue: [ anObject asSymbol ] ifFalse: [ anObject ]) ifAbsentPut: [Set new]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCDependencySorter >> unresolvedRequirementsFor: anItem [
	"The provisions are Symbols (see addProvision:)"
	<gtPharoPatch: #StrictComparison>
	^ (anItem requirements collect: [ :each | each isString ifTrue: [ each asSymbol ] ifFalse: [ each ] ]) difference: provided
]
