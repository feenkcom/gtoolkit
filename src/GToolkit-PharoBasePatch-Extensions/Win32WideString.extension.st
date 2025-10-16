Extension { #name : #Win32WideString }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
Win32WideString >> asString [
	| out r codepage |

	(handle isNil or: [ handle isNull ])
		ifTrue: [ ^ '' ].

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

	[ r := OSPlatform current
		wideCharacterToMultiByteCodepage: codepage
		flags: 0
		input: self
		inputLen: self size + 1
		output: out
		outputLen: out size.

	r = 0 ifTrue: [ self error: 'Error while transforming windows wide string using codepage ', codepage asString ].

	^ out allButLast utf8Decoded ] ensure: [out unpinInMemory]
]
