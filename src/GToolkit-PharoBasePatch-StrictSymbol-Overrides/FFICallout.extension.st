Extension { #name : #FFICallout }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout class >> initializeTypeAliases [
	"self initializeTypeAliases"
	TypeAliases := GtStringContentDictionary newFromPairs:
	#(
		"not really a type, useful only as return type or with pointers "
		void 				FFIVoid
		"0/!0  <-> false/true "
		bool 				FFIBool
		"fixed size integer types, byte order is platform dependent "
		int8 				FFIInt8
		uint8 				FFIUInt8
		int16 				FFIInt16
		uint16 			FFIUInt16
		int32 				FFIInt32
		uint32 			FFIUInt32
		int64 				FFIInt64
		uint64 			FFIUInt64
		" aliases to common C compiler types.. some of them are platform dependent,
		  some is not.. to be sorted out later "
		signedByte 		int8
		unsignedByte 	uint8
		signedShort 		int16
		unsignedShort 	uint16
		signedChar 		int8
		unsignedChar 	uint8
		schar 				int8
		uchar 				uint8
		signedLong 		int32
		unsignedLong 	uint32
		sbyte 				int8
		byte 				uint8
		short 				int16
		ushort 			uint16
		long 				FFILong
		ulong 				FFIULong
		longlong 			int64
		ulonglong 		uint64
		uint 				uint32
		int 				int32
		"unsigned for sizes.. usually same size as platform's word size"
		size_t 			FFISizeT
		"character type. uint8 <-> accepts Character/Smallint as argument, converts
		 return to Character "
		Character 		FFICharacterType
		char 				FFICharacterType
		"Floats fixed-size. platform-dependent byte order"
		float16 			FFIFloat16
		float32 			FFIFloat32
		float64 			FFIFloat64
		float128 			FFIFloat128
		"Floats, C type name aliases"
		float 				float32
		double 			float64
		shortFloat 		float16
		"Special types"
		oop 				FFIOop
		ByteArray       FFIOop
		ExternalAddress FFIOop)
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> loaderForArgNamed: argName [
	| loader |

	"try getting the argument from the method arguments"
	loader := self loaderFromMethodArgsNamed: argName.
	loader
		ifNil: [  "special case, receiver argument"argName = #self
				ifTrue: [ loader := self receiverArgumentLoader ].
			loader
				ifNil: [  "Ask the requestor for the argument"loader := requestor
							ffiInstVarArgument: argName
							generator: self.
					loader
						ifNil: [ | binding |
							binding := requestor ffiBindingOf: argName.
							binding ifNil: [ FFIVariableNameNotFound signalFor: argName ].
							loader := FFIClassVariableArgument new
									argName: argName;
									yourself ] ] ].
	^ loader
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
FFICallout >> resolveType: aTypeName [
	" a type name could be
	 - a class variable name
	- a class name
	- a type name
	- a type name, followed by arbitrary number pointer chars - $*"

	| name newName resolver binding ptrArity |
	newName := aTypeName.
	ptrArity := 0.	"resolve aliases and pointers"
	[ name := newName asString trimRight.
	newName := self aliasForType: name.
	newName last = $*
		ifTrue: [ ptrArity := ptrArity + 1.
			newName := newName allButLast ].
	name sameContentAs: newName ] whileFalse.

	resolver := requestor
			ifNotNil: [ requestor isClass ifTrue: [ requestor instanceSide ] ifFalse: [ requestor ] ]
			ifNil: [ self class ].

	binding := resolver ffiBindingOf: name asSymbol.
	binding
		ifNotNil: [ ^ (binding value asExternalTypeOn: self) pointerArity: ptrArity ].

	^ self error: 'Unable to resolve external type: ' , aTypeName asString
]
