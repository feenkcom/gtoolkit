"Startup code should appear below."
Transcript
    cr;
	show: 'GToolkit ';
	show: GtImage version versionString;
	show: ' in a Docker container is ready.';
	cr;
	show: 'Use `COPY run.st /gtoolkit/` Dockerfile command to configure what to execute.';
	cr.

"Remove the next line if you're starting a server, this is just a template."
Smalltalk snapshot: false andQuit: true.
