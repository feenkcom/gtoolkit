private
do: aBlock on: anException do: anotherBlock
	"I give a chance to my subclass to not handle the exception is needed"
	aBlock
		on: anException
		do: anotherBlock