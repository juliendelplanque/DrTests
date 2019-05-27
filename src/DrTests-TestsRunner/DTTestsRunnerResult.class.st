"
I build a tree with the testsResult listed in groups: 
-Errors
-Failures
-Skipped tests
-Passed test
I am used in DrTestsUI to show the results in a orderly manner.
"
Class {
	#name : #DTTestsRunnerResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'testsResult'
	],
	#category : #'DrTests-TestsRunner'
}

{ #category : #accessing }
DTTestsRunnerResult >> buildTreeForUI [
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
DTTestsRunnerResult >> color [
	testsResult errors isEmpty
		ifFalse: [ ^ Color named: 'red' ].
	testsResult failures isEmpty
		ifFalse: [ ^ Color named: 'yellow' ].
	^ Color named: 'green'
]

{ #category : #accessing }
DTTestsRunnerResult >> summarizeInfo [
	"Text showed in miniDrTests with info of the result "

	^ String
		streamContents: [ :s | 
			s
				<< self testsResult passed size asString;
				<< ' passed';
				<< String cr;
				<< self testsResult failures size asString;
				<< ' failures';
				<< String cr;
				<< self testsResult errors size asString;
				<< ' errors';
				<< String cr;
				<< self testsResult skipped size asString;
				<< ' skipped' ]
]

{ #category : #accessing }
DTTestsRunnerResult >> testsResult [
	^ testsResult
]

{ #category : #accessing }
DTTestsRunnerResult >> testsResult: anObject [
	testsResult := anObject
]
