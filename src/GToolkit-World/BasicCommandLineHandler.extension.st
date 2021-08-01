Extension { #name : #BasicCommandLineHandler }

{ #category : #'*GToolkit-World' }
BasicCommandLineHandler >> gtHandleArgument: aString [

	"give priority to subcommands"
	self handleSubcommand == self
		ifFalse: [ ^ self ].

	"check for default options"
	aString ifEmpty: [ ^ self default ].
	
	aString = '--version'
		ifTrue: [ ^ self version ].
		
	aString = '--help'
		ifTrue: [ ^ self help ].
		
	aString = '--list'
		ifTrue: [ ^ self list ].
		
	aString = '--copyright'
		ifTrue: [ ^ self copyright ].
		
	aString = '--no-quit'
		ifTrue: [ ^ self noQuit ].
	aString = '--interactive'
		ifTrue: [ ^ self noQuit ].
	
	"none of the previous options matched hence we output an error message"
	self error.
]
