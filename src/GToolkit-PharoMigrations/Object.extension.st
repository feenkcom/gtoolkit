Extension { #name : #Object }

{ #category : #'*GToolkit-PharoMigrations' }
Object >> forPharo11: pharo11Block forPharo10: pharo10Block [
	"Evaluate one of the blocks based on the pharo's major version"
	| unsupportedVersionBlock |
	
	unsupportedVersionBlock := [
		self error: 'Unsupported pharo version: ',SystemVersion current major asString ].
	
	^ self
		forPharo12: unsupportedVersionBlock
		forPharo11: pharo11Block
		forPharo10: pharo10Block
		newer: unsupportedVersionBlock
		older: unsupportedVersionBlock
]

{ #category : #'*GToolkit-PharoMigrations' }
Object >> forPharo11OrNewer: pharo11Block forPharo10: pharo10Block [
	"Evaluate one of the blocks based on the pharo's major version"
	| unsupportedVersionBlock |
	
	unsupportedVersionBlock := [
		self error: 'Unsupported pharo version: ',SystemVersion current major asString ].
		
	^ self
		forPharo12: pharo11Block
		forPharo11: pharo11Block
		forPharo10: pharo10Block
		newer: pharo11Block
		older: unsupportedVersionBlock
]

{ #category : #'*GToolkit-PharoMigrations' }
Object >> forPharo12: pharo12Block forPharo11: pharo11Block forPharo10: pharo10Block newer: newerBlock older: olderBlock [
	"Evaluate one of the blocks based on the pharo's major version"
	
	SystemVersion current major > 12
		ifTrue: [ ^ newerBlock value ].

	SystemVersion current major = 12
		ifTrue: [ ^ pharo12Block value ].
	SystemVersion current major = 11
		ifTrue: [ ^ pharo11Block value ].
	SystemVersion current major = 10
		ifTrue: [ ^ pharo10Block value ].

	^ olderBlock value
]
