"
!How to work with GitHub and Metacello

Before being able to work with GitHub, you first need to setup the credentials for GitHub.

[[[
| credentials store |
credentials := IceSshCredentials new
	host:  #'*';
	username: 'git';
	publicKey: 'PATH/TO/id_rsa.pub';
	privateKey: 'PATH/TO/id_rsa';""
	keyPassphrase: 'potential rsa passphrase';""
	yourself.
store := IceCredentialStore current.
store storeSshCredential: credentials forHostname: credentials host.
IceCredentialsProvider useCustomSsh: true.
]]]

Once credentials are set, we can load the actual code via a script that loads a Metacello baseline. For example, try loading:

[[[
Metacello new
	baseline: 'Faker';
	repository: 'github://feenkcom/faker/src';
	load.
]]]

This will load the baseline and the code from the repository and will make it available in the image.

Once you have a Git repository, you can further use the Git interface.


"
Class {
	#name : #GtWorkWithGitHubIcebergMetacelloHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}
