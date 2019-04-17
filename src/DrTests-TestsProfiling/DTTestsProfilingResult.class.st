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
				subResults:
					((self testsResult
						select:
							[ :testCaseToTimeTaken | testCaseToTimeTaken testResult errors isNotEmpty ])
						collect: [ :testCaseToTimeTaken | 
							DTTreeLeaf new
								content: testCaseToTimeTaken;
								yourself ]);
				yourself).
			(DTTreeNode new
				name: 'Failures';
				subResults:
					((self testsResult
						select:
							[ :testCaseToTimeTaken | testCaseToTimeTaken testResult failures isNotEmpty ])
						collect: [ :testCaseToTimeTaken | 
							DTTreeLeaf new
								content: testCaseToTimeTaken;
								yourself ]);
				yourself).
			(DTTreeNode new
				name: 'Skipped tests';
				subResults:
					((self testsResult
						select:
							[ :testCaseToTimeTaken | testCaseToTimeTaken testResult skipped isNotEmpty ])
						collect: [ :testCaseToTimeTaken | 
							DTTreeLeaf new
								content: testCaseToTimeTaken;
								yourself ]);
				yourself).
			(DTTreeNode new
				name: 'Passed tests';
				subResults:
					((self testsResult
						select:
							[ :testProfilerResult | testProfilerResult testResult passed isNotEmpty ])
						collect: [ :testCaseToTimeTaken | 
							DTTreeLeaf new
								content: testCaseToTimeTaken;
								yourself ]);
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
