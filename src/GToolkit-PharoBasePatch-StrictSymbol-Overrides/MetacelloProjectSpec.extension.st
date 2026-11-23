Extension { #name : #MetacelloProjectSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloProjectSpec >> configMethodBodyOn: aStream indent: indent fromShortCut: fromShortCut [
	"The file and the class name can each be a String or a Symbol"
	<gtPharoPatch: #StrictComparison>

	| hasVersionString hasOperator hasProjectPackage hasLoads hasClassName hasPreLoadDoIt hasPostLoadDoIt |
	hasClassName := self hasClassName.
	hasVersionString := self configHasVersionString.
	hasOperator := operator isNotNil.
	hasProjectPackage := self hasRepository or: [ hasClassName & self getFile isNotNil ].
	hasLoads := self loads isNotNil.
	hasPreLoadDoIt := self getPreLoadDoIt isNotNil.
	hasPostLoadDoIt := self getPostLoadDoIt isNotNil.
	hasClassName ifTrue: [
		hasVersionString | hasOperator | hasProjectPackage | hasLoads
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		aStream nextPutAll: 'className: ' , self className printString.
		hasVersionString | hasPreLoadDoIt | hasPostLoadDoIt | hasOperator | hasLoads | hasProjectPackage ifTrue: [ aStream nextPut: $; ] ].
	hasVersionString ifTrue: [
		| vs |
		hasClassName | hasOperator | hasProjectPackage | hasLoads | hasPreLoadDoIt | hasPostLoadDoIt
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		vs := self versionString.
		aStream nextPutAll: 'versionString: '.
		vs isSymbol ifTrue: [ aStream nextPut: $# ].
		aStream nextPutAll: vs asString printString.
		hasPreLoadDoIt | hasPostLoadDoIt | hasOperator | hasProjectPackage | hasLoads ifTrue: [ aStream nextPut: $; ] ].
	hasPreLoadDoIt ifTrue: [
		hasClassName | hasOperator | hasProjectPackage | hasLoads | hasPreLoadDoIt
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		aStream nextPutAll: 'preLoadDoIt: '.
		self preLoadDoIt value isSymbol
			ifTrue: [
				aStream
					nextPut: $#;
					nextPutAll: self preLoadDoIt value asString printString ]
			ifFalse: [ aStream nextPutAll: self preLoadDoIt value asString ].
		hasPostLoadDoIt | hasOperator | hasProjectPackage | hasLoads ifTrue: [ aStream nextPut: $; ] ].
	hasPostLoadDoIt ifTrue: [
		hasClassName | hasOperator | hasProjectPackage | hasLoads | hasPostLoadDoIt
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		aStream nextPutAll: 'postLoadDoIt: '.
		self postLoadDoIt value isSymbol
			ifTrue: [
				aStream
					nextPut: $#;
					nextPutAll: self postLoadDoIt value asString printString ]
			ifFalse: [ aStream nextPutAll: self postLoadDoIt value asString ].
		hasOperator | hasProjectPackage | hasLoads ifTrue: [ aStream nextPut: $; ] ].
	hasOperator ifTrue: [
		hasClassName | hasVersionString | hasProjectPackage | hasLoads | hasPreLoadDoIt | hasPostLoadDoIt
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		aStream nextPutAll: 'operator: #' , self operator asString printString.
		hasProjectPackage | hasLoads ifTrue: [ aStream nextPut: $; ] ].
	hasLoads ifTrue: [
		hasClassName | hasVersionString | hasOperator | hasProjectPackage | hasPreLoadDoIt | hasPostLoadDoIt
			ifTrue: [
				aStream
					cr;
					tab: indent + 1 ]
			ifFalse: [ aStream space ].
		aStream nextPutAll: 'loads: #('.
		self loads do: [ :str | aStream nextPutAll: str printString , ' ' ].
		aStream nextPut: $).
		hasProjectPackage ifTrue: [ aStream nextPut: $; ] ].
	hasProjectPackage ifTrue: [
		| hasName hasRepo |
		hasRepo := self hasRepository.
		hasName := (self file isString and: [ self className isString ])
			ifTrue: [ self file asString ~= self className asString ]
			ifFalse: [ self file ~= self className ].
		hasName ifTrue: [
			hasClassName | hasVersionString | hasOperator | hasLoads | hasPreLoadDoIt | hasPostLoadDoIt
				ifTrue: [
					aStream
						cr;
						tab: indent + 1 ]
				ifFalse: [ aStream space ].
			aStream nextPutAll: 'file: ' , self file printString.
			hasRepo ifTrue: [ aStream nextPut: $; ] ].
		hasRepo ifTrue: [
			| repos |
			repos := self repositories map values.
			repos size = 1
				ifTrue: [
					fromShortCut
						ifTrue: [
							hasClassName | hasVersionString | hasOperator | hasLoads | hasPreLoadDoIt | hasPostLoadDoIt | hasName
								ifTrue: [
									aStream
										cr;
										tab: indent + 1 ]
								ifFalse: [ aStream space ] ]
						ifFalse: [
							aStream
								cr;
								tab: indent + 1 ].
					repos first configMethodCascadeOn: aStream lastCascade: true ]
				ifFalse: [
					aStream cr.
					self repositories configMethodCascadeOn: aStream indent: indent ] ] ]
]
