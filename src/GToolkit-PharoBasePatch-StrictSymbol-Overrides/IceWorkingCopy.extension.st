Extension { #name : #IceWorkingCopy }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> initialize [
	super initialize.
	shouldIgnoreNotifications := false.
	
	packages := GtStringContentDictionary new.
	referenceCommit := repository newNoCommit.
	self basicSetProject: referenceCommit project.
	properties := referenceCommit properties asBornProperties
]
