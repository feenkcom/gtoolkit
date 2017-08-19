private
layoutLayer: aCollection radius: oldRadius from: aFromAngle to: aToAngle
	
	| delta childRadius maximumRadius myRadius fromAngle toAngle |
	"Initialize with default value"
	maximumRadius := oldRadius.
	aCollection isEmpty
		ifFalse:
			[myRadius := oldRadius + self gap + (self maximumRadius: aCollection).
			childRadius := oldRadius + self gap + (self maximumDiameter: aCollection).	"This is a purely optical tweak"
			(aCollection size = 1 and: [aToAngle - aFromAngle = (2 * Float pi)])
				ifTrue:
					[delta := 0.4 * Float pi.
					fromAngle := 0.8 * Float pi.
					toAngle := fromAngle + delta]
				ifFalse:
					[delta := (aToAngle - aFromAngle) / aCollection size.
					fromAngle := aFromAngle.
					toAngle := aFromAngle + delta].
			aCollection
				do:
					[:child | 
					translator translateTopLeftOf: child to: (Point
								r: myRadius
								theta: toAngle - (delta / 2.0)).
					"child
						translateTo:
							(Point
								radius: myRadius
								theta: toAngle - (delta / 2.0))."
					maximumRadius := maximumRadius
						max:
							(self
								layoutLayer: (self childrenFor: child)
								radius: childRadius
								from: fromAngle
								to: toAngle).
					fromAngle := toAngle.
					toAngle := toAngle + delta]].
	^maximumRadius