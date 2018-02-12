public - basic
read: jsonSchema withMapping: messageSymbol on: aReadStream 
	"Read a JSON string using json schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	| reader |
	reader := (NeoJSONReader on: aReadStream).
	self perform: messageSymbol with: reader.
	^ reader nextAs: jsonSchema