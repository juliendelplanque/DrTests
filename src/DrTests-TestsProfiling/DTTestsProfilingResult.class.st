Class {
	#name : #DTTestsProfilingResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'testsResult',
		'timeData'
	],
	#category : #'DrTests-TestsProfiling'
}

{ #category : #accessing }
DTTestsProfilingResult >> buildTreeForUI [
	^ DTTreeNode new
		subResults:
			{(DTTreeNode new
				name: 'Errors';
				subResults: (self testsResult errors collect: #asResultForDrTest);
				yourself).
			(DTTreeNode new
				name: 'Failures';
				subResults: (self testsResult failures collect: #asResultForDrTest);
				yourself).
			(DTTreeNode new
				name: 'Skipped tests';
				subResults: (self testsResult skipped collect: #asResultForDrTest);
				yourself).
			(DTTreeNode new
				name: 'Passed tests';
				subResults: (self testsResult passed collect: #asResultForDrTest);
				yourself)};
		yourself
]

{ #category : #accessing }
DTTestsProfilingResult >> testsResult [
	^ testsResult
]

{ #category : #accessing }
DTTestsProfilingResult >> testsResult: anObject [
	testsResult := anObject
]

{ #category : #accessing }
DTTestsProfilingResult >> timeData [
	^ timeData
]

{ #category : #accessing }
DTTestsProfilingResult >> timeData: anObject [
	timeData := anObject
]
