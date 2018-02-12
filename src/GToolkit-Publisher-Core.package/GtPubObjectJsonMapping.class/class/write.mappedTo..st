public - basic
write: aDSObject mappedTo: mappingSymbol 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			prettyPrint: false;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: aDSObject ].