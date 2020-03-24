"
Provide a simple way to include all the version information in a bug report.

Inspecting an instance of this class will show a text editor with the version information.

Alternatively it can be run with the command line similar to: 

[[[language=bash
gtoolkit gtoolkit.image clap gtVersionInfo
]]]
"
Class {
	#name : #GtVersionInfo,
	#superclass : #Object,
	#category : #'GToolkit-SystemInfo'
}

{ #category : #'command line' }
GtVersionInfo class >> commandLine [ 
	<commandline>

	^ (ClapCommand withName: 'gtVersionInfo')
		description: 'Gtoolkit version information';
		add: ClapFlag forHelp;
		meaning: [ :args |
			args
				atName: 'help'
				ifFound: [ :help | 
					help
						value;
						exitSuccess ].
			self new systemInfoOn: self stdout ]
]

{ #category : #'terminal i/o' }
GtVersionInfo class >> stdout [ 

	^ ZnNewLineWriterStream on: Stdio stdout
]

{ #category : #private }
GtVersionInfo >> commitInfoOn: aStream [
	"Write the repository commit numbers on a stream"

	(IceRepository registry
		sorted: [ :a :b | a name < b name ])
			select: [ :each | self shouldReportRepository: each ]
			thenDo: [ :repository |
				aStream
					<< repository name;
					<< ': ';
					<< repository headCommit id;
					cr 	]
]

{ #category : #inspecting }
GtVersionInfo >> gtStatusFor: aView [
	<gtView>

	^ aView textEditor 
		title: 'Status';
		priority: 5;
		text: [ self systemInfoString ]
]

{ #category : #private }
GtVersionInfo >> imageInfoOn: aStream [ 

	aStream 
		<< SmalltalkImage current lastUpdateString;
		cr.
]

{ #category : #asserting }
GtVersionInfo >> shouldReportRepository: aRepository [

	^ aRepository remotes
		detect: [ :each | each owner = 'feenkcom' ]
		ifFound: [ true ] 
		ifNone: [ false ].
]

{ #category : #private }
GtVersionInfo >> systemInfoOn: aStream [

	self commitInfoOn: aStream.
	aStream cr; cr.
	self imageInfoOn: aStream.
	aStream cr; cr.
	self vmInfoOn: aStream.

]

{ #category : #accessing }
GtVersionInfo >> systemInfoString [

	^ String streamContents: [ :stream |
		self systemInfoOn: stream ]
]

{ #category : #private }
GtVersionInfo >> vmInfoOn: aStream [

	aStream
		<< Smalltalk vm version;
		cr.
]
