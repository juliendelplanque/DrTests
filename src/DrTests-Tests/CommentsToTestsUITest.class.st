"
A DrTestsUITest is a test class for testing the behavior of DrTests-CommentsToTestsTest  UI
"
Class {
	#name : #CommentsToTestsUITest,
	#superclass : #TestCase,
	#instVars : [
		'drTest'
	],
	#category : #'DrTests-Tests'
}

{ #category : #running }
CommentsToTestsUITest >> setUp [

	super setUp.
	drTest := DrTestsUI on: { DTCommentToTest }.
]

{ #category : #running }
CommentsToTestsUITest >> testRunTestsUpdatesUIWithResults [

	drTest startButton performAction.
	
	self assert: drTest resultsList roots notEmpty
]
