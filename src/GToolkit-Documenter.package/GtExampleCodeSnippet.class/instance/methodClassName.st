accessing
methodClassName
	<return: #String or: nil>
	^ methodDefinition ifNotNil: [ :aMethodDefinition | aMethodDefinition parent name ]