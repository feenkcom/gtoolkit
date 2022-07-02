Class {
	#name : #GtGitRepositoryWithoutJenkinsFile,
	#superclass : #GtLeafConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile class >> instance [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> description [
	^ 'A repository in the Feenk organisation should specify the Jenkins file to trigger a build for Glamorous Toolkit'
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> issues [
	| project directories |
	project := GtGhGToolkitProject default.
	directories := project ownedRepositories collect: [ :aRepository | 
		aRepository baselineRepository icebergRepository workingCopy fileSystem ].
	^ directories select: [ :aDirectory | (aDirectory / 'Jenkinsfile') exists not ]
]

{ #category : #accessing }
GtGitRepositoryWithoutJenkinsFile >> name [ 
	^ 'Git repositories from feenkcom should specify a Jenkinsfile'
]
