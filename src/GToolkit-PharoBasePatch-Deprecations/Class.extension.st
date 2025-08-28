Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aPackageSymbol [
	"Added to allow for a simplified subclass creation experience. "

	^ self
		forPharo12: [ "self
				deprecated: 'This method uses the old way of creating classes. The new way is to use the ShiftClassInstaller.'
				transformWith: '`@rcv subclass: `@name instanceVariableNames: `@instVar classVariableNames: `@classVar package: `@package'
						-> '`@rcv classInstaller
			make: [ :builder |
				builder
					superclass: `@rcv;
					name: `@name;
					slotsFromString: `@instVar;
					sharedVariablesFromString: `@classVar;
					package: `@package;
					environment: `@rcv environment ]'."

			self classInstaller
				make: [ :builder | 
					builder
						superclass: self;
						name: aSubclassSymbol;
						layoutClass: self classLayout class;
						slotsFromString: instVarNameList;
						sharedVariablesFromString: classVarNames;
						category: aPackageSymbol;
						environment: self environment ] ]
		forPharo11AndPharo10: [ self
				subclass: aSubclassSymbol
				instanceVariableNames: instVarNameList
				classVariableNames: classVarNames
				poolDictionaries: ''
				package: aPackageSymbol ]
]
