"Startup code template."
Transcript
    cr;
	show: 'GToolkit ';
	show: GtImage version versionString;
	show: ' in a Docker container is ready.';
	cr;
	show: 'Use `COPY run.st /gtoolkit/` Dockerfile command to configure what to execute.';
	cr.

"Remove (or change) the next line if you're starting a server."
Smalltalk snapshot: false andQuit: true.
