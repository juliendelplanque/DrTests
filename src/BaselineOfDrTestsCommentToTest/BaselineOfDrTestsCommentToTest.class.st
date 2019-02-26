Class {
	#name : #BaselineOfDrTestsCommentToTest,
	#superclass : #BaselineOf,
	#category : #BaselineOfDrTestsCommentToTest
}

{ #category : #baselines }
BaselineOfDrTestsCommentToTest >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'DrTests';
				package: 'DrTests-TestsRunner' with: [ spec requires: #('DrTests') ];
				package: 'DrTests-RottenTests'with: [ spec requires: #('DrTests') ];
				package: 'DrTests-CommentToTest' with: [ spec requires: #('DrTests' 'DrTests-TestsRunner') ]
				]
]
