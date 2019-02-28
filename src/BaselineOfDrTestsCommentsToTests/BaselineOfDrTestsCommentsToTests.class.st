Class {
	#name : #BaselineOfDrTestsCommentsToTests,
	#superclass : #BaselineOf,
	#category : #BaselineOfDrTestsCommentsToTests
}

{ #category : #baselines }
BaselineOfDrTestsCommentsToTests >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'DrTests';
				package: 'DrTests-TestsRunner' with: [ spec requires: #('DrTests') ];
				package: 'DrTests-RottenTests'with: [ spec requires: #('DrTests') ];
				package: 'DrTests-CommentsToTests' with: [ spec requires: #('DrTests' 'DrTests-TestsRunner') ]
				]
]
