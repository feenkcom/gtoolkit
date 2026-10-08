Extension { #name : #Collection }

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Collection >> asCommaString [

	"Return collection printed as 'a, b, c' "

	"#('a' 'b' 'c') asCommaString >>> 'a, b, c'"
	"#('a') asCommaString >>> 'a'"
	"#() asCommaString >>> ''"
	"'foo' asCommaString >>> 'f, o, o'"
	"(10 to: 25 by: 5) asCommaString >>> '10, 15, 20, 25'"

	^ String streamContents: [ :s | self asStringOn: s delimiter: ', ' ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Collection >> asCommaStringAnd [

	"Return collection printed as 'a, b and c' "

	"#( 'a' 'b' 'c') asCommaStringAnd >>> 'a, b and c'"
	"#('a') asCommaStringAnd >>> 'a'"
	"#() asCommaStringAnd >>> ''"
	"'foo' asCommaStringAnd >>> 'f, o and o'"
	"(10 to: 25 by: 5) asCommaStringAnd >>> '10, 15, 20 and 25'"

	^String streamContents: [:s | self asStringOn: s delimiter: ', ' last: ' and ']
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Collection >> asStringOn: aStream delimiter: delimString [
	<gtPharoPatch: #Pharo13>
	
	"Print elements on a stream separated
	with a delimiter String like: 'a, b, c'
	Uses #asString instead of #print:."

	"(String streamContents: [:s|
		'abcd' asStringOn: s delimiter: '->'])
	>>> 'a->b->c->d'"

	self
		do: [ :elem | aStream nextPutAll: elem asString ]
		separatedBy: [ aStream nextPutAll: delimString ]
]

{ #category : #'*GToolkit-PharoBasePatch-Deprecations' }
Collection >> printOn: aStream delimiter: delimString [
	<gtPharoPatch: #Pharo13>
	"Print elements on a stream separated
	with a delimiter String like: 'a, b, c'"

	"(String streamContents: [:s|
		{ 10. 'hello'. $x } printOn: s delimiter: ', '])
		>>> '10, ''hello'', $x'"

	self do: [:elem | aStream print: elem] separatedBy: [aStream nextPutAll: delimString]
]
