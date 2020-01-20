"
!How to work with GitHub, Metacello and Iceberg

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

Once credentials are set, we can load the actual code via a Metacello script. For example, try loading:

[[[
Metacello new
	baseline: 'Faker';
	repository: 'github://feenkcom/faker/src';
	load.
]]]

Or you can use the Iceberg interface from within the legacy Morphic World.
"
Class {
	#name : #GtWorkWithGitHubIcebergMetacelloHowToGuide,
	#superclass : #Object,
	#category : #'GToolkit-Docs'
}
