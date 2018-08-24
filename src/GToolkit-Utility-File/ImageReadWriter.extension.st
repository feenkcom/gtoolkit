Extension { #name : #ImageReadWriter }

{ #category : #'*GToolkit-Utility-File' }
ImageReadWriter class >> gtReaderClassFromStream: aBinaryStream [
	"Return a class reader to a given binary stream.
	Return nil, if there is not a reader that understands a stream format"
	<return: #Behavior or: nil>
	^ [ self readerClassFromStream: aBinaryStream ] 
			on: Error 
			do: [ :anException | anException return: nil ]
]
