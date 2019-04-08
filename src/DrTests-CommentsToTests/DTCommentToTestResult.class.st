Class {
	#name : #DTCommentToTestResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'testsResult'
	],
	#category : #'DrTests-CommentsToTests'
}

{ #category : #accessing }
DTCommentToTestResult >> buildTreeForUI [
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
				name: 'Passed tests';
				subResults: (self testsResult passed collect: #asResultForDrTest);
				yourself)};
			yourself
]

{ #category : #accessing }
DTCommentToTestResult >> testsResult [
	^ testsResult
]

{ #category : #accessing }
DTCommentToTestResult >> testsResult: anObject [
	testsResult := anObject
]
