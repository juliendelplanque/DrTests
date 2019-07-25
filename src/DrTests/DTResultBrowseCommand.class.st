Class {
	#name : #DTResultBrowseCommand,
	#superclass : #DTLeafResultCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
DTResultBrowseCommand >> execute [
	self context browseSelectedResult
]

{ #category : #hooks }
DTResultBrowseCommand >> initialize [
	super initialize.
	self basicName: 'Browse'
]
