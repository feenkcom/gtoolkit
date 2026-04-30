Extension { #name : #Collection }

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
