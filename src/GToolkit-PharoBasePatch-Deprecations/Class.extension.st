Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aPackageSymbol [
	"Added to allow for a simplified subclass creation experience. "

	^ self
		forPharo12AndNewer: [ "self
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
			  		  fillClassSideFromEnvironment: self environment;
						slotsFromString: instVarNameList;
						sharedVariablesFromString: classVarNames;
						package: aPackageSymbol;
						environment: self environment ] ]
		forPharo11: [ self
				subclass: aSubclassSymbol
				instanceVariableNames: instVarNameList
				classVariableNames: classVarNames
				poolDictionaries: ''
				package: aPackageSymbol ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: t instanceVariableNames: f classVariableNames: d poolDictionaries: s category: cat [

	^ self
		forPharo12AndNewer: [  "self
			deprecated: 'This method uses the old way of creating classes. The new way is to use the ShiftClassInstaller.'
			transformWith:
				'`@rcv subclass: `@name instanceVariableNames: `@instVar classVariableNames: `@classVar poolDictionaries: `@pools category: `@package'
				-> '`@rcv classInstaller
				make: [ :builder |
					builder
						superclass: `@rcv;
						name: `@name;
						slotsFromString: `@instVar;
						sharedVariablesFromString: `@classVar;
						sharedPools: `@pools;
						category: `@package;
						environment: `@rcv environment ]'."

			self classInstaller make: [ :builder |
				  builder
					  superclass: self;
					  name: t;
					  layoutClass: self classLayout class;
					  fillClassSideFromEnvironment: self environment;
					  slotsFromString: f;
					  sharedVariablesFromString: d;
					  sharedPoolsFromString: s;
					  category: cat;
					  environment: self environment ] ]
		forPharo11: [
			self
				subclass: t
				instanceVariableNames: f
				classVariableNames: d
				poolDictionaries: s
				package: cat	]
]
