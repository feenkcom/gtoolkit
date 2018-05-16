utility - system environment
createClassNamed: aClassNameString during: aBlockClosure 
	"Create a class in a temporary package and execute a block"
	| theClass |
	self
		assert: [ aClassNameString isSymbol ] 
		description: [ 'Class name should be a symbol' ].
	self
		assert: [ aClassNameString size > 1 ] 
		description: [ 'Class name should have at least one character' ].
	self 
		assert: [ (self environment includesKey: aClassNameString) not ]
		description: [ 'Class name should not exists' ].
	self
		assert: [ aBlockClosure notNil ] 
		description: [ 'Valuable object (block closure) should be initialized' ].
	theClass := Object 
		subclass: aClassNameString 
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'GToolkit-DocumenterTemporaryPackage'.
	[ aBlockClosure cull: theClass cull: aClassNameString.
	] ensure: [ theClass ifNotNil: [ theClass removeFromSystem ] ].