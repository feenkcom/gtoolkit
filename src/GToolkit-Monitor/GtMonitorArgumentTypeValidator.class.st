Class {
	#name : #GtMonitorArgumentTypeValidator,
	#superclass : #GtMonitorTypeValidator,
	#instVars : [
		'link',
		'pragmas',
		'validations'
	],
	#category : #'GToolkit-Monitor-Type Validator'
}

{ #category : #initialization }
GtMonitorArgumentTypeValidator >> initialize [
	super initialize.
	
	pragmas := self pragmas.
	validations := self validations
]

{ #category : #installation }
GtMonitorArgumentTypeValidator >> install [	
	self uninstall.

	link := MetaLink new
		metaObject: self;
		selector: #validateArguments:receiver:method:;
		arguments: #(arguments receiver method).
	
	self relevantMethods do: [ :eachMethod | eachMethod ast link: link ]
]

{ #category : #installation }
GtMonitorArgumentTypeValidator >> isInstalled [
	^ link notNil
]

{ #category : #initialization }
GtMonitorArgumentTypeValidator >> link [
	^ link
]

{ #category : #'private - validation' }
GtMonitorArgumentTypeValidator >> logErrors: theErrors in: aCompiledMethod [
	NonInteractiveTranscript stderr
			cr; cr;
			nextPutAll: '======================================================='; cr; cr;
			nextPutAll: 'Arguments type validation failed in ';
			nextPutAll: aCompiledMethod printString; cr; cr;
			nextPutAll: 'Errors:'; cr.

		theErrors do: [ :eachError |
			NonInteractiveTranscript stderr
				space; space;
				nextPutAll: eachError asString; cr ].
		
		NonInteractiveTranscript stderr cr; nextPutAll: '======================================================='; cr; cr; cr.
]

{ #category : #initialization }
GtMonitorArgumentTypeValidator >> pragmas [
	^ self validations keys
]

{ #category : #'private - validation' }
GtMonitorArgumentTypeValidator >> relevantMethods [
	^ self pragmas flatCollect: [ :eachPragma | eachPragma gtPragmas result collect: #yourself ] as: Set
]

{ #category : #installation }
GtMonitorArgumentTypeValidator >> uninstall [
	link
		ifNotNil: [ :aMetaLink | aMetaLink uninstall ].
	link := nil
]

{ #category : #'private - validation' }
GtMonitorArgumentTypeValidator >> validateArgument: anArgumentObject isKindOf: aClassName [
	^ self class environment
		at: aClassName
		ifPresent: [ :aClass |
			(anArgumentObject isKindOf: aClass)
				ifTrue: [ GtMonitorTypeValidatorOk uniqueInstance ]
				ifFalse: [ GtMonitorTypeValidatorWrongClassError new
					expectedClassName: aClassName;
					actualClassName: anArgumentObject class name ] ]
		ifAbsent: [ GtMonitorTypeValidatorClassTypeDoesNotExistError new argumentClassName: aClassName ]
]

{ #category : #'private - validation' }
GtMonitorArgumentTypeValidator >> validateArgument: anArgumentObject satisfies: aCondition [
	| satisfies |
	
	satisfies := [ aCondition isSymbol
		ifTrue: [ anArgumentObject perform: aCondition ]
		ifFalse: [ (self class evaluate: aCondition asString) value: anArgumentObject ] ]
			on: Error
			do: [ :anError | false ].
		
	^ satisfies
		ifTrue: [ GtMonitorTypeValidatorOk uniqueInstance ]
		ifFalse: [ GtMonitorTypeValidatorDoesNotSatisfyConditionError new condition:aCondition ]
]

{ #category : #'private - validation' }
GtMonitorArgumentTypeValidator >> validateArguments: theArguments receiver: aReceiverObject method: aCompiledMethod [
	| theInterestingPragmas supportedPragmas theArgumentsDictionary validationResults errors |
	
	supportedPragmas := self pragmas.
	theInterestingPragmas := aCompiledMethod pragmas select: [ :eachPragma | supportedPragmas includes: eachPragma selector ].
	
	theArgumentsDictionary := Dictionary new.
	aCompiledMethod argumentNames
		with: theArguments
		do: [ :eachName :eachArgument | theArgumentsDictionary at: eachName put: eachArgument ].
	
	validationResults := theInterestingPragmas collect: [ :eachPragma |
		theArgumentsDictionary
			at: eachPragma arguments first
			ifPresent: [ :anArgumentObject |
				validations
					at: eachPragma selector
					ifPresent: [ :aValidation |
						| aResult |
						aResult := aValidation value: anArgumentObject value: eachPragma.
						aResult isOk
							ifFalse: [
								aResult
									argumentName: eachPragma arguments first;
									argumentObject: anArgumentObject;
									pragma: eachPragma;
									method: aCompiledMethod ].
						aResult ]
					ifAbsent: [ GtMonitorTypeValidatorOk uniqueInstance ] ]
			ifAbsent: [ GtMonitorTypeValidatorOk uniqueInstance ] ].

	errors := validationResults reject: [ :eachResult | eachResult isOk ].
	errors ifNotEmpty: [ :theErrors |
		self logErrors: theErrors in: aCompiledMethod.
		
		self error: (String streamContents: [ :aStream | 
			theErrors do: [ :eachError | aStream
				nextPutAll: eachError argumentName;
				space;
				nextPut: $(;
				nextPutAll: eachError argumentObject class name;
				nextPut: $) ] separatedBy: [ aStream nextPut: $,; space ].
			aStream
				nextPutAll: ' had wrong type(s) in ';
				nextPutAll: aCompiledMethod printString ]) ]
]

{ #category : #initialization }
GtMonitorArgumentTypeValidator >> validations [
	^ {
		#argument:isKindOf: -> [ :anArgumentObject :aPragma | self validateArgument: anArgumentObject isKindOf: aPragma arguments second ].
		#argument:satisfies: -> [ :anArgumentObject :aPragma | self validateArgument: anArgumentObject satisfies: aPragma arguments second ].
	} asDictionary
]
