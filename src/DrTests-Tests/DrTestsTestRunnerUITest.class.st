Class {
	#name : #DrTestsTestRunnerUITest,
	#superclass : #TestCase,
	#instVars : [
		'drTest'
	],
	#category : #'DrTests-Tests'
}

{ #category : #tests }
DrTestsTestRunnerUITest >> setUp [

	super setUp.
	drTest := DrTestsUI on: { DTTestsRunner }.
]

{ #category : #tests }
DrTestsTestRunnerUITest >> testRunTestsUpdatesUIWithResults [
	drTest startButton performAction.
	self assert: drTest resultsList roots notEmpty
]
