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
				subResults:
					(self testsResult failures collect: #asResultForDrTest)
						asOrderedCollection;
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
	testsResult errors ifNotEmpty: [ ^ self theme dangerBackgroundColor ].
	testsResult failures ifNotEmpty: [ ^ self theme warningBackgroundColor ].
	^ self theme successBackgroundColor
]

{ #category : #accessing }
DTTestsRunnerResult >> summarizeInfo [
	"Text showed in miniDrTests with info of the result "

	^ String
		streamContents: [ :s | 
			s
				print: self testsResult passed size;
				<< ' passed';
				cr;
				print: self testsResult failures size;
				<< ' failures';
				cr;
				print: self testsResult errors size;
				<< ' errors';
				cr;
				print: self testsResult skipped size;
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
