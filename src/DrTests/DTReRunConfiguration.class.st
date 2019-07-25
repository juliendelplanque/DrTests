Class {
	#name : #DTReRunConfiguration,
	#superclass : #DTPluginConfiguration,
	#instVars : [
		'testToReRun',
		'previousResult'
	],
	#category : #'DrTests-Model'
}

{ #category : #converting }
DTReRunConfiguration >> asTestSuite [
	^ self testToReRun class buildSuiteFromMethods: {self testToReRun selector}.
]

{ #category : #'as yet unclassified' }
DTReRunConfiguration >> handleResults: aPluginResult for: aPlugin [
	^ aPlugin handleReRunResult: aPluginResult forConfiguration: self
]

{ #category : #accessing }
DTReRunConfiguration >> items [
	^ { self testToReRun }
]

{ #category : #accessing }
DTReRunConfiguration >> previousResult [
	^ previousResult
]

{ #category : #accessing }
DTReRunConfiguration >> previousResult: anObject [
	previousResult := anObject
]

{ #category : #accessing }
DTReRunConfiguration >> testToReRun [
	^ testToReRun
]

{ #category : #accessing }
DTReRunConfiguration >> testToReRun: anObject [
	testToReRun := anObject
]
