Extension { #name : #Win32WideString }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Win32WideString >> asString [
	<gtPharoPatch: #Pharo>
	| out  |

	(handle isNil or: [ handle isNull ])
		ifTrue: [ ^ '' ].

	[|r codepage|
	codepage := 65001.
	r := OSPlatform current
		wideCharacterToMultiByteCodepage: codepage
		flags: 0
		input: self
		inputLen: self size + 1
		output: ExternalAddress null
		outputLen: 0.

	r = 0 ifTrue: [ self error: 'Error while transforming windows wide string using codepage ', codepage asString ].

	out := ByteArray new: r.
	out pinInMemory.

	r := OSPlatform current
		wideCharacterToMultiByteCodepage: codepage
		flags: 0
		input: self
		inputLen: self size + 1
		output: out
		outputLen: out size.

	r = 0 ifTrue: [ self error: 'Error while transforming windows wide string using codepage ', codepage asString ].

	^ out allButLast utf8Decoded] ensure: [
		self getHandle unpinInMemory.
		out ifNotNil: [ :aBuffer | aBuffer unpinInMemory ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Win32WideString class >> fromString: aString [
	<gtPharoPatch: #Pharo>
	| r wideString anUTF8String codepage |

	anUTF8String := aString utf8Encoded copyWith: 0.
	codepage := 65001.

	[
	|requestedSize|
	requestedSize := OSPlatform current
		multiByteToWideCharacterCodepage: codepage
		flags: 0
		input: anUTF8String 
		inputLen: anUTF8String size + 1
		output: self null
		outputLen: 0.

	requestedSize = 0
		ifTrue: [ self error: 'Error while transforming utf8 string ',
				aString, ' using codepage ', codepage asString  ].

	wideString := self new: requestedSize.

	r := OSPlatform current
		multiByteToWideCharacterCodepage: codepage
		flags: 0
		input: anUTF8String 
		inputLen: anUTF8String size + 1
		output: wideString
		outputLen: wideString byteSize.] 
	ensure: [
		anUTF8String unpinInMemory.
		wideString getHandle unpinInMemory.].

	r = 0 ifTrue: [ self error: 'Error while transforming utf8 string ', aString, ' using codepage ', codepage asString  ].

	^ wideString
]
