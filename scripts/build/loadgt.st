EpMonitor current disable.
Metacello new
  baseline: 'GToolkit';
  repository: 'github://feenkcom/gtoolkit/src';
  load.
EpMonitor current enable.

GtDocumenterConstants localGtDirectory asFileReference ensureCreateDirectory.
Transcript crShow: ('localGtDirectory: ', GtDocumenterConstants localGtDirectory).
docFolders := (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'doc') asOrderedCollection.

docFolders addAll:  (((IceRepository registry detect: [ :r | r name = 'gtoolkit' ]) location parent) allChildrenMatching: 'data').

docFolders do: [ :each |
	icebergIndex := each absolutePath segments indexOf: 'iceberg'.
	size := each absolutePath segments size.
	topSegments := each absolutePath segments asOrderedCollection copyFrom: (icebergIndex + 1) to: size.

	s := String streamContents: [:s | topSegments asStringOn: s delimiter:'/'].
	Transcript crShow: ('copying ', each printString, ' to ', s).
	[each copyAllTo: (GtDocumenterConstants localGtDirectory asFileReference / s) ] on: FileExists do: [ :e | Transcript crShow: e printString ]].

World closeAllWindowsDiscardingChanges.

#GtWorld asClass openTour.

Smalltalk snapshot: true andQuit: false.
