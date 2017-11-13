private - adding / removing
addMethod: aMethod
	"Create a new editor on a given method, add it to the scene and return that editor"
	<return: #BrEditorElement>
	| anEditorElement |

	self
		assert: [ (self hasOpenedMethod: aMethod) not ]
		description: [ 'Can not add already opened method' ].

	anEditorElement := self createAndAddElementForMethod: aMethod.	
	^ anEditorElement