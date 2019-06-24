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
DTReRunConfiguration class >> result: aPluginResult testSuite: aTestSuite [
	^ self new
		result: aPluginResult;
		testSuite: aTestSuite;
		yourself.
]
