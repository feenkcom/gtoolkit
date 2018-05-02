actions
applyCodeChanges
	self assert: [ theLog notNil ] description: 'Epicea log is not initialized.'.
	self isValid ifFalse: [ ^ self ].
	EpLogBrowserOperationFactory new
		logBrowserModel: theLog;
		entries: theLog entries;
		errorHandlerBlock: errorHandler;
		applyCodeChanges.