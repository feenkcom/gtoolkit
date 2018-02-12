converting
asDataPost
	"Convert a post into GtPubDataPost"
	| data |
	data := GtPubDataPost new.
	data
		nonce: self nonce;
		title: self title;
		description: self description.
	^ data