private
treatBinding: anAssocOrNil of: aSymbol
	"Subclasses can treat existing or missing bindings of a variable named aSymbol"
	<return: #LiteralVariable or: nil>
	^ anAssocOrNil ifNil: [ 
		bindings addNamed: aSymbol value: nil.
		bindings bindingOf: aSymbol ]