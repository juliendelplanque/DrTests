Class {
	#name : #DTReRunConfiguration,
	#superclass : #DTPluginConfiguration,
	#instVars : [
		'testToReRun',
		'pluginResult'
	],
	#category : #DrTests
}

{ #category : #'configuration building' }
DTReRunConfiguration class >> result: aPluginResult testSuite: aTestSuite testToRun: anotherTestSuite [
	^ self new
		pluginResult: aPluginResult;
		testSuite: aTestSuite;
		testToReRun: anotherTestSuite;
		yourself.
]

{ #category : #accessing }
DTReRunConfiguration >> asTestSuite [
	testSuite := TestSuite new.
	self testToReRun
		reject: #isAbstract
		thenDo: [ :s | testSuite addTest: s suite ].
	^ testSuite
]

{ #category : #accessing }
DTReRunConfiguration >> pluginResult [
	^ pluginResult
]

{ #category : #accessing }
DTReRunConfiguration >> pluginResult: anObject [
	pluginResult := anObject
]

{ #category : #accessing }
DTReRunConfiguration >> testToReRun [
	^ testToReRun
]

{ #category : #accessing }
DTReRunConfiguration >> testToReRun: anObject [
	testToReRun := anObject
]
