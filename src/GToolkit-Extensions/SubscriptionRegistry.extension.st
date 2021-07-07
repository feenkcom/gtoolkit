Extension { #name : #SubscriptionRegistry }

{ #category : #'*GToolkit-Extensions' }
SubscriptionRegistry >> gtSubscriptionsFor: aView [
	<gtView>
	self subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 50;
		items: [ self subscriptions asArray ];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Subscriber' item: [ :aSubscription | aSubscription subscriber ];
		column: 'Announcement' item: [ :aSubscription | aSubscription announcementClass ];
		column: 'Kind' item: [ :aSubscription | aSubscription class ]
]
