Extension { #name : #Class }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategorySymbol [

	^ (self << aSubclassSymbol
			slotsFromString: instVarNameList;
			sharedVariablesFromString: classVarNames;
			category: aCategorySymbol) install
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aPackageSymbol [
	"Added to allow for a simplified subclass creation experience. "

	^ (self << aSubclassSymbol
			slotsFromString: instVarNameList;
			sharedVariablesFromString: classVarNames;
			package: aPackageSymbol) install
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames poolDictionaries: poolDictionariesString category: aCategory [

	^ (self << aSubclassSymbol
			slotsFromString: instVarNameList;
			sharedVariablesFromString: classVarNames;
			sharedPoolsFromString: poolDictionariesString;
			category: aCategory) install
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> subclass: aSubclassSymbol instanceVariableNames: instVarNameList classVariableNames: classVarNames poolDictionaries: poolDictionariesString package: aPackageName [

	^ (self << aSubclassSymbol
			slotsFromString: instVarNameList;
			sharedVariablesFromString: classVarNames;
			sharedPoolsFromString: poolDictionariesString;
			package: aPackageName) install
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> variableByteSubclass: className instanceVariableNames: instVarNameList classVariableNames: classVarNames category: cat [

	^ self classInstaller make: [ :builder |
		  builder
			  superclass: self;
			  name: className;
			  layoutClass: (self checkForCompiledMethodLayout: className);
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  category: cat;
			  environment: self environment ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> variableByteSubclass: className instanceVariableNames: instVarNameList classVariableNames: classVarNames package: package [

	^ self classInstaller make: [ :builder |
		  builder
			  superclass: self;
			  name: className;
			  layoutClass: (self checkForCompiledMethodLayout: className);
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  package: package;
			  environment: self environment ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> variableSubclass: className instanceVariableNames: instVarNameList classVariableNames: classVarNames category: cat [

	^ self classInstaller make: [ :builder |
		  builder
			  superclass: self;
			  name: className;
			  layoutClass: VariableLayout;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  category: cat;
			  environment: self environment ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Class >> variableSubclass: className instanceVariableNames: instVarNameList classVariableNames: classVarNames package: package [

	^ self classInstaller make: [ :builder |
		  builder
			  superclass: self;
			  name: className;
			  layoutClass: VariableLayout;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  package: package;
			  environment: self environment ]
]
