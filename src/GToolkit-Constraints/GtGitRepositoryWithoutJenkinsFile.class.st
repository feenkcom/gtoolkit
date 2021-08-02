Class {
	#name : #GtGitRepositoryWithoutJenkinsFile,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> description [
	^ 'A repository should specify the Jenkins file to trigger a build for Glamorous Toolkit'
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> issues [
	| project feenkRepositories directories |
	project := BaselineOfGToolkit gtRlProjectWithRepository: 'github://feenkcom/gtoolkit/src'.
	feenkRepositories := project withAllRepositories select: [ :aRepository |
		aRepository ownerName = 'feenkcom' and: [
			(#('pillar' 'XPath' 'XMLWriter' 'Chrysal' 'mustache' 'XMLParser' 'OSSubprocess' 'Containers-PropertyEnvironment' 'tffi-dev' 'taskit' 'pharo-unicode') includes: aRepository icebergRepository workingCopy fileSystem basename) not
			] ].
	directories := feenkRepositories collect: [ :aRepository | 
		aRepository icebergRepository workingCopy fileSystem ].
	^ directories select: [ :aDirectory | (aDirectory / 'Jenkinsfile') exists not ]
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> name [ 
	^ 'Git repositories from feenkcom should specify a Jenkinsfile'
]
