Class {
	#name : #GtMandatoryWeakSubscriptions,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #'api - concerned announcements' }
GtMandatoryWeakSubscriptions class >> concernedAnnouncementClasses [
	^ {GtSpotterAnnouncement.
		GtGitAnnouncement.
		GtGitRepositorySelected}
]

{ #category : #'api - concerned announcements' }
GtMandatoryWeakSubscriptions class >> isConcernedAnnouncementClass: aClass [
	^ aClass isClass
		and: [ self concernedAnnouncementClasses
				anySatisfy: [ :anAnnouncementClass | 
					(aClass instanceSide inheritsFrom: anAnnouncementClass)
						or: [ aClass == anAnnouncementClass ] ] ]
]

{ #category : #accessing }
GtMandatoryWeakSubscriptions >> description [
	^ 'Some subscriptions should be weak otherwise there are mixed (weak and strong) subscriptions. As a consequence weak subscriptions are not going to be garbage-collected.'
]

{ #category : #accessing }
GtMandatoryWeakSubscriptions >> issues [
	<return: #OrderedCollection>
	^ '
`@receiver `{ :node | 
		node isMessage and: [ node selector ~= #weak ] }
	when: `announcement `{ :node | 
		node isGlobalVariable and: [ 
			GtMandatoryWeakSubscriptions
				isConcernedAnnouncementClass: node binding value ] }
	send: `@selector
	to: `@object.' gtASTMatches result toArray wait
]

{ #category : #accessing }
GtMandatoryWeakSubscriptions >> name [
	^ 'Mandatory weak subscriptions'
]
