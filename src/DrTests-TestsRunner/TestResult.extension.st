Extension { #name : #TestResult }

{ #category : #'*DrTests-TestsRunner' }
TestResult >> asResultsForDrTests [
	^ DTResultGroup new
		subResults:
			{(DTResultGroup new
				name: 'Errors';
				subResults: (self errors collect: #asResultForDrTest);
				yourself).
			(DTResultGroup new
				name: 'Failures';
				subResults: (self failures collect: #asResultForDrTest);
				yourself).
			(DTResultGroup new
				name: 'Skipped tests';
				subResults: (self skipped collect: #asResultForDrTest);
				yourself).
			(DTResultGroup new
				name: 'Passed tests';
				subResults: (self passed collect: #asResultForDrTest);
				yourself)};
			yourself
]
