Class {
	#name : #DTTestCoverage,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-TestCoverage'
}

{ #category : #'api - accessing' }
DTTestCoverage class >> pluginName [
	^ 'Test Coverage'
]

{ #category : #'api - accessing' }
DTTestCoverage class >> weight [
	^ 3
]

{ #category : #api }
DTTestCoverage >> convertToResultsForDrTests: coverageResult [
	^ DTTreeNode new
]

{ #category : #api }
DTTestCoverage >> itemsToBeAnalysedFor: packagesSelected [
	^ RPackage organizer packages
]

{ #category : #api }
DTTestCoverage >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestCoverage >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTTestCoverage >> runCoverage: aDTpluginConfiguration [
]

{ #category : #api }
DTTestCoverage >> runForConfiguration: aDTpluginConfiguration [
	| results covConf |
	covConf := DTTestCoverageConfiguration
		items: aDTpluginConfiguration items.
	results := DTTestCoverageResult new
		testsResult: (self runCoverage: aDTpluginConfiguration);
		yourself.
	^ results
]

{ #category : #api }
DTTestCoverage >> startButtonHelp [
	^ 'Run test coverage in selected packages' translated
]

{ #category : #api }
DTTestCoverage >> startButtonLabel [
	^ 'Run Coverage' translated
]
