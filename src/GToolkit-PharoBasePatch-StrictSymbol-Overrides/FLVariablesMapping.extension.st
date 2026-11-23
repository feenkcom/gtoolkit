Extension { #name : #FLVariablesMapping }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FLVariablesMapping >> instanceVariableNamesToSerialize [
	"fuelIgnoredInstanceVariableNames answers Strings (e.g. TestExecutionEnvironment class), the instance variable names are Symbols"
	<gtPharoPatch: #StrictComparison>
	| ignoredInstanceVariableNames instanceVariableNamesToSerialize |
	ignoredInstanceVariableNames := theClass fuelIgnoredInstanceVariableNames collect: [ :each |
		each isString ifTrue: [ each asSymbol ] ifFalse: [ each ] ].
	instanceVariableNamesToSerialize := OrderedCollection new.

	theClass instanceVariableNamesDo: [:name | 
		(ignoredInstanceVariableNames includes: name) 
			ifFalse: [ instanceVariableNamesToSerialize add: name ]].

	^ instanceVariableNamesToSerialize
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FLVariablesMapping >> map: sourceName to: destinationName [
	"notIgnoredVariables are Symbols when serializing and Strings when materializing"
	<gtPharoPatch: #StrictComparison>
	| indexOfVariableToMap aName |
	aName := sourceName isString ifTrue: [ sourceName asString ] ifFalse: [ sourceName ].
	indexOfVariableToMap := notIgnoredVariables findFirst: [ :each |
		(each isString and: [ aName isString ])
			ifTrue: [ each asString = aName ]
			ifFalse: [ each = aName ] ].
	indexOfVariableToMap > 0
		ifTrue: [ mapping 
			at: indexOfVariableToMap 
			put: (theClass
				instVarIndexFor: destinationName
				ifAbsent: [self error: 'Bad variable destination.'])].
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FLVariablesMapping >> materializeTraitVariablesWith: anObject [
	"If there are any trait variables, store their values.
	Only at this point do we know that we have trait variables
	because the trait composition is a reference that must be
	fully loaded first.
	
	See FLBehaviorCluster>>installLayout:withFormat:variableNames:into:
	and ClassDescription>>fuelRecomputeSlotScopeWithTraits."
	"possibleTraitVariables is keyed by the decoded names (Strings, see initializeMaterializingFrom:), slot names are Symbols"
	<gtPharoPatch: #StrictComparison>

	possibleTraitVariables ifNil: [ ^ self ].

	anObject class traitComposition slots do: [ :slot |
		| index |
		index := anObject class instVarIndexFor: slot name.
		index > 0 ifTrue: [
			anObject
				instVarAt: index
				put: (possibleTraitVariables
					at: slot name asString
					ifAbsent: nil) ] ]
]
