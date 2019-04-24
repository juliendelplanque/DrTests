Class {
	#name : #DTTestCoverageTestForUseInCovergare,
	#superclass : #TestCase,
	#instVars : [
		'mockObj'
	],
	#category : #'DrTests-TestCoverage-MocksForTests'
}

{ #category : #running }
DTTestCoverageTestForUseInCovergare >> setUp [
	super setUp.
	mockObj := MockForCoverage new.

	
]

{ #category : #running }
DTTestCoverageTestForUseInCovergare >> testMethod1forMock [
	self assert: mockObj method1ForMock equals: 2
]

{ #category : #running }
DTTestCoverageTestForUseInCovergare >> testMethod2forMock [
	self
		assert: 5
		equals: 5
]
