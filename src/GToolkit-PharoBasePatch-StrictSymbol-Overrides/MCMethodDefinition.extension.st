Extension { #name : #MCMethodDefinition }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCMethodDefinition >> overridenMethodOrNil [
	"Answer the method that I've overriden on load. 

	Preconditions: 
	  - self actualClass is installed in the System Dictionary.
	  - self isOverrideMethod is true."
	"The protocols of the change records are Strings, the category can be a Symbol"
	<gtPharoPatch: #StrictComparison>
	
	| realMethod |
	realMethod := self actualClass
		compiledMethodAt: self selector
		ifAbsent: [ ^ nil ].
		
	^ SourceFiles
		changeRecordsFor: realMethod
		detect: [ :protocol | (protocol isString and: [ category isString ])
			ifTrue: [ protocol asString ~= category asString ]
			ifFalse: [ protocol ~= category ] ]
]
