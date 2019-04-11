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
		reject: [ :p | 
			p name includesSubstring: 'Tests' ]
]

{ #category : #api }
DTTestCoverage >> resultButtonHelp [
	^ 'Browse the method selected in the results list.' translated
]

{ #category : #api }
DTTestCoverage >> resultButtonLabel [
	^ 'Browse method' translated
]

{ #category : #api }
DTTestCoverage >> runCoverage: aDTpluginConfiguration [
	"Run tests and report the methods that are not executed"

	| suite link methods testClasses notExecuted |
	methods := aDTpluginConfiguration items
		flatCollect: [ :p | p methods ].
	testClasses := aDTpluginConfiguration packagesSelected
		flatCollect: [ :p | p classes ].
	suite := self suiteFor: testClasses.
	"resetResult;"
	link := MetaLink new
		selector: #tagExecuted;
		metaObject: #node.
	[ methods do: [ :meth | meth ast link: link ].
	[ self runTestSuites: {suite} ]
		ensure: [ link uninstall ] ] valueUnpreemptively.
	notExecuted := methods reject: [ :each | each ast hasBeenExecuted ].
	notExecuted isEmpty
		ifTrue: [ UIManager default
				inform: 'Congratulations. Your tests cover all code under analysis.' ]
		ifFalse: [ UIManager default
				inform:
					'Not Covered Code ('
						, (100 - (100 * notExecuted size // methods size)) printString
						, '% Code Coverage)' ].

	"cleanup the annotations"
	methods
		do: [ :each | each ast removeProperty: #tagExecuted ifAbsent: [  ] ].
	^ notExecuted
]

{ #category : #api }
DTTestCoverage >> runForConfiguration: aDTpluginConfiguration [
	| results covConf |
	covConf := DTTestCoverageConfiguration
		items: aDTpluginConfiguration items packages: aDTpluginConfiguration packagesSelected .
	results := DTTestCoverageResult new
		methodList: (self runCoverage: covConf);
		yourself.
	^ results
]

{ #category : #api }
DTTestCoverage >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		subscribe: TestAnnouncement
		do: [ :testAnnouncement | 
			self announcer
				announce: (DTStatusUpdate message: ('Running test {1}.' format: {testAnnouncement test asString})) ].
	[ aTestSuite run: aResult ]
		ensure: [ aTestSuite unsubscribe: TestAnnouncement ]
]

{ #category : #api }
DTTestCoverage >> runTestSuites: testSuites [
	| result |
	result := TestAsserter classForTestResult new.
	CurrentExecutionEnvironment
		runTestsBy: [ testSuites
				do: [ :testSuite | self runSuite: testSuite withResult: result ]
				displayingProgress: 'Running Tests' ].
]

{ #category : #api }
DTTestCoverage >> startButtonHelp [
	^ 'Run test coverage in selected packages' translated
]

{ #category : #api }
DTTestCoverage >> startButtonLabel [
	^ 'Run Coverage' translated
]

{ #category : #api }
DTTestCoverage >> suiteFor: classesSelected [
	"Return the suite for all the selected test case classes"

	^ TestSuite new
		in: [ :suite | 
			classesSelected
				do: [ :each | 
					each isAbstract
						ifFalse: [ each addToSuiteFromSelectors: suite ] ].
			suite name: 'Test' ]
]
