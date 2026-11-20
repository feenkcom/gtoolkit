Extension { #name : #ZnRequestLine }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnRequestLine >> method: string [
	"ZnConstants knownHTTPMethods are Symbols; ZnRequestLine>>#readFrom: passes the method of the request line as a String.
	Look its Symbol up without interning it (Symbol class>>#findInterned: answers nil for an unknown name), so that a client
	cannot add Symbols to the image."
	<gtPharoPatch: #StrictComparison>
	| aSymbol |
	aSymbol := string isSymbol
		ifTrue: [ string ]
		ifFalse: [ string isString ifTrue: [ Symbol findInterned: string ] ifFalse: [ string ] ].
	method := ZnConstants knownHTTPMethods
		detect: [ :each | each = aSymbol ]
		ifNone: [ (ZnUnknownHttpMethod method: string) signal ]
]
