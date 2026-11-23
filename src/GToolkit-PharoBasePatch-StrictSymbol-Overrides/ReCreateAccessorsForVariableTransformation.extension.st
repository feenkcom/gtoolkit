Extension { #name : #ReCreateAccessorsForVariableTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ReCreateAccessorsForVariableTransformation >> usesAssignmentOf: aString in: aClass classVariable: isClassVar [
	"Returns whether the variable aString is used in a assignement sequence e.g., x := y := 2 in the class and its subclasses."
	"Selectors are Symbols, the variable name is often a String: the getter of the variable must not count"
	<gtPharoPatch: #StrictComparison>
	| matcher definingClass |
	matcher := self parseTreeSearcher.
	matcher
		answer: false;
		matches: aString , ' := ``@object'
			do: [ :aNode :answer |
			answer
				or: [ aNode isUsedAsReturnValue and: [ aNode methodNode selector ~= aString asSymbol ] ] ].
	definingClass := isClassVar
		ifTrue: [ aClass instanceSide ]
		ifFalse: [ aClass ].
	^ (definingClass withAllSubclasses
		,
			(isClassVar
				ifTrue: [ definingClass classSide withAllSubclasses ]
				ifFalse: [ #() ])
		anySatisfy: [ :each |
			((isClassVar
				ifTrue: [ each whichSelectorsReferToClassVariable: aString ]
				ifFalse: [ each whichSelectorsReferToInstanceVariable: aString ])
				anySatisfy:
					[ :sel | self checkClass: each selector: sel using: matcher ]) ])
]
