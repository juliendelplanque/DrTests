"
I am a DrTestPlugin.
I show the percentage of covered methods with tests and show the list of the uncovered methods.
"
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
	| suite link methods testClasses notExecuted result |
	result := DTTestCoverageResult new.
	methods := aDTpluginConfiguration items
		flatCollect: [ :p | p methods reject: [ :meth | meth isTestMethod or: meth methodClass isTestCase  ] ].
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
	notExecuted := methods
		reject: [ :each | each ast hasBeenExecuted ].
	notExecuted isEmpty
		ifTrue: [ result percent: 100 ]
		ifFalse: [ result
				percent: 100 - (100 * notExecuted size // methods size);
				methodList: notExecuted ].

	"cleanup the annotations"
	methods
		do: [ :each | each ast removeProperty: #tagExecuted ifAbsent: [  ] ].
	^ result
]

{ #category : #api }
DTTestCoverage >> runForConfiguration: aDTpluginConfiguration [
	| results covConf |
	covConf := DTTestCoverageConfiguration
		items: aDTpluginConfiguration items
		packages: aDTpluginConfiguration packagesSelected.
	results := self runCoverage: covConf.
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
						ifFalse: [ each isTestCase
								ifTrue: [ each addToSuiteFromSelectors: suite ] ] ].
			suite name: 'Test' ]
]
