Extension { #name : #ChangeRecord }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ChangeRecord >> asMCMethodDefinition [
	"Creates a MCMethodDefinition from the receiver when this was created for a method (type=#method)"
	
	self type == #method ifFalse: [ ^nil ]. "This case shouldn't happen"
	
	^ MCMethodDefinition 
		className: class
		classIsMeta: meta
		selector: self methodSelector
		category: (self 
			forPharo12AndNewer: [self protocol] 
			forPharo11: [self category])
		timeStamp: stamp
		source: self string
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ChangeRecord >> gtReadTimeStampFromTokens: tokens format: aFormatString [
	"Answer a TimeStamp that corresponds to my (text) stamp"

	^ tokens size >= 2
		ifTrue: [
			[
			| time date |
			date := aFormatString 
				ifNil:[ 
					Date fromString: (tokens at: tokens size - 1)]
				ifNotNil: [
					Date 
						readFrom: (tokens at: tokens size - 1) 
						pattern: aFormatString ].
			
			time := Time fromString: tokens last.
			DateAndTime date: date time: time ]
				on: Error
				do: [ :ex | ex return: DateAndTime new ] ]
		ifFalse: [ DateAndTime new ]
]

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
ChangeRecord >> timeStamp [
	<gtPharoPatch: #Pharo12>
	"Answer a TimeStamp that corresponds to my (text) stamp"

	^ self 
		forPharo13AndNewer: [ 
			(DateAndTime fromMethodTimestamp: self stamp) 
				ifNil: [ DateAndTime new ]] 
		forPharo12: [
			| tokens |
			tokens := self stamp findTokens: Character separators.
			self gtReadTimeStampFromTokens: tokens format: 'm/d/yyyy' ] 
		forPharo11: [ 
			| tokens |
			tokens := self stamp findTokens: Character separators.
			self gtReadTimeStampFromTokens: tokens format: nil]
]
