Extension { #name : #SystemAnnouncer }

{ #category : #'*GToolkit-PharoBasePatch-Extensions' }
SystemAnnouncer >> classRenamed: aClass from: oldClassName to: newClassName [
	<gtPharoPatch: #Pharo>
	
	self announce: (ClassRenamed class: aClass oldName: oldClassName newName: newClassName).
	
	"Announce a second announcement after all the normal class announcement was handled."
	#GtClassRenamedDone asClassIfPresent: [ :anAnnouncementClass |
		self announce: (anAnnouncementClass 
			class: aClass oldName: oldClassName newName: newClassName) ]
]
