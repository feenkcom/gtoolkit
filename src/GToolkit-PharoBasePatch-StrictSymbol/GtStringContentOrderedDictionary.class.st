Class {
	#name : #GtStringContentOrderedDictionary,
	#superclass : #OrderedDictionary,
	#category : #'GToolkit-PharoBasePatch-StrictSymbol-Collections'
}

{ #category : #accessing }
GtStringContentOrderedDictionary >> dictionaryClass [
	^ GtStringContentDictionary
]

{ #category : #accessing }
GtStringContentOrderedDictionary >> indexOfKey: aKey ifAbsent: aBlock [
	"Find the position of aKey by content, as my dictionary finds the key (see #dictionaryClass)"

	1 to: self size do: [ :i | ((orderedKeys at: i) sameContentAs: aKey) ifTrue: [ ^ i ] ].
	^ aBlock value
]

{ #category : #private }
GtStringContentOrderedDictionary >> orderedKeysIndexOf: aKey [
	"Find the position of aKey by content, as my dictionary finds the key (see #dictionaryClass): a String and a Symbol with the same characters are the same key.
	Like #indexOf:, scan all of orderedKeys: #removeKey:ifAbsent: removes the key from the dictionary first, so #size is already one less"

	1 to: orderedKeys size do: [ :i | ((orderedKeys at: i) sameContentAs: aKey) ifTrue: [ ^ i ] ].
	^ 0
]

{ #category : #accessing }
GtStringContentOrderedDictionary >> replaceKey: aKey with: otherKey [
	"Find the position of aKey by content, as my dictionary finds the key (see #dictionaryClass)"
	| value index |

	value := self at: aKey.
	index := self orderedKeysIndexOf: aKey.
	dictionary removeKey: aKey.
	dictionary at: otherKey put: value.
	orderedKeys at: index put: otherKey
]
