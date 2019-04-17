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
			{(self buildTreeNode
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
			(self buildTreeNode
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
			(self buildTreeNode
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
			(self buildTreeNode
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

{ #category : #private }
DTTestsProfilingResult >> buildTreeNode [
	"Returns a node with the sub-results aggregator initialized in a way that it sum the durations of sub results."

	^ DTTreeNode new
		subResultsAggregator: [ :subResults | 
			subResults
				inject: 0 milliSecond
				into: [ :totalDuration :dtTreeLeaf | totalDuration + dtTreeLeaf content duration ] ];
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
