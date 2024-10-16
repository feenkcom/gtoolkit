Extension { #name : #MCPackageManager }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCPackageManager class >> packageRenamed: anAnnouncement [
	self allManagers
		detect: [ :each | each packageName sameContentAs: anAnnouncement newName ]
		ifFound: [ :newPackage | newPackage modified: true ].
	(self allManagers detect: [ :each | each packageName = anAnnouncement oldName ])
		unload
]
