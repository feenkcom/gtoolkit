Extension { #name : #AnnouncementSubscription }

{ #category : #'*GToolkit-PharoBasePatch-Subscriptions' }
AnnouncementSubscription >> makeWeak [
	"GT patch: the weak builder of my announcer builds the subscription that replaces me,
	see implementors of #weakSubscriptionFrom:"
	<gtPharoPatch: #Pharo>
	^announcer replace: self with: (announcer weak weakSubscriptionFrom: self)
]
