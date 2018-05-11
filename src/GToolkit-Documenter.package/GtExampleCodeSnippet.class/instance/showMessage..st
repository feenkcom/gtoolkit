accessing
showMessage: aSymbol
	"Set a message name that should be used to display an example preview (result)"
	self assert: [ aSymbol isSymbol ] description: [ 'Message name has to be a symbol' ].
	showMessage := aSymbol