Class {
	#name : #BaselineOfDrTests,
	#superclass : #BaselineOf,
	#category : #BaselineOfDrTests
}

{ #category : #baselines }
BaselineOfDrTests >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				package: 'DrTests';
				package: 'DrTests-TestsRunner' with: [ spec requires: #('DrTests' 'SUnitVisitor') ];
				package: 'DrTests-TestCoverage' with: [ spec requires: #('DrTests' 'SUnitVisitor') ];
				package: 'DrTests-TestsProfiling' with: [ spec requires: #('DrTests' 'SUnitVisitor') ];
				package: 'DrTests-RottenTests'with: [ spec requires: #('DrTests' 'RottenTestsFinder') ];
				package: 'DrTests-Tests' with: [ spec requires: #('DrTests') ];
				package: 'DrTests-CommentsToTests' with: [ spec requires: #('DrTests' 'DrTests-TestsRunner') ].
			spec baseline: 'SUnitVisitor' with: [ 
				spec
					repository: 'github://juliendelplanque/SUnit-Visitor:v2.0.0/src' ].
			spec baseline: 'RottenTestsFinder' with: [ 
				spec
					repository: 'github://juliendelplanque/RottenTestsFinder/src' ] ]
]
