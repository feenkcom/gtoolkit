Class {
	#name : #GtSystemUtility,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#category : 'GToolkit-Utility-System'
}

{ #category : #'ring definition' }
GtSystemUtility class >> classDefinitionFromString: aString [
	"Extract a class name, e.g., MyClass and return a class definition"
	<return: #RGClassDefinition>
	| aDefinition |
	self 
		assert: [ aString isString ] 
		description: [ 'Class definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Class definition name has to be a non-empty string' ].
		
	aDefinition := (RGClassDefinition named: aString).
	^ aDefinition isDefined
		ifTrue: [ aDefinition realClass asRingDefinition ] 
		ifFalse: [ aDefinition ]
]

{ #category : #'ring definition' }
GtSystemUtility class >> methodDefinitionFromString: aString [
	"Extract a method definition, e.g., MyClass>>#methodOne and return method definition"
	<return: #RGMethodDefinition>
	| aCollection aMethodClassName aMethodName |
	self 
		assert: [ aString isString ] 
		description: [ 'Method definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Method definition name has to be a non-empty string' ].

	aCollection := '>>#' split: aString.
	aMethodClassName := aCollection first trimBoth.
	aMethodName := aCollection size = 2 ifTrue: [ aCollection second trimBoth ] ifFalse: [ '' ].

	^ (RGMethodDefinition 
		class: (RGBehaviorDefinition named: aMethodClassName) 
		selector: aMethodName asSymbol) asActive.
]

{ #category : #'ring definition' }
GtSystemUtility class >> packageDefinitionFromString: aString [
	"Extract a package name, e.g., MyPackage and return a package definition"
	<return: #RGPackage>
	self 
		assert: [ aString isString ] 
		description: [ 'Package definition name has to be a string' ].
	self 
		assert: [ aString notEmpty ] 
		description: [ 'Package definition name has to be a non-empty string' ].
	
	^ RGPackage named: aString asSymbol
]
