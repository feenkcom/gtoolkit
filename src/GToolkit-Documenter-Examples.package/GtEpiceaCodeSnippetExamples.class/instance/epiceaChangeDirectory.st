ombu files
epiceaChangeDirectory
	<gtExample>
	<label: 'Directory with Epicea changes'>
	| epiceaDir |
	epiceaDir := (fileSystemExamples rootDirectory / self epiceaChangeDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir