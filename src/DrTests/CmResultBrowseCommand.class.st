Class {
	#name : #CmResultBrowseCommand,
	#superclass : #CmResultCommand,
	#category : #DrTests
}

{ #category : #hooks }
CmResultBrowseCommand >> execute [
	self context browseSelectedResult
]

{ #category : #hooks }
CmResultBrowseCommand >> initialize [
	super initialize.
	self basicName: 'Browse'
]
