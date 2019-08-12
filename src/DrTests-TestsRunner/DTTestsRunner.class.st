Class {
	#name : #DTTestsRunner,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-TestsRunner'
}

{ #category : #'api - accessing' }
DTTestsRunner class >> pluginName [
	^ 'Tests Runner'
]

{ #category : #'api - accessing' }
DTTestsRunner class >> weight [
	^ 0
]

{ #category : #api }
DTTestsRunner >> allowMiniDrTests [
	^ true
]

{ #category : #'configuration building' }
DTTestsRunner >> buildConfigurationFrom: aDrTests [
	"Builds a configuration from the plugin by reading the information held by the UI (aDrTests)."
	^ DTTestsRunnerConfiguration
		items: aDrTests selectedItems
		packages: aDrTests packagesSelected
]

{ #category : #api }
DTTestsRunner >> buildContextualMenuGroupWith: presenterIntance [
	^ (CmCommandGroup named: 'TestRunnerResult context menu') asSpecGroup
		basicDescription: 'Commands related to re-run a result.';
		register: (DTRerunFailuresCommand forSpec context: presenterIntance);
		register: (DTRerunErrorsCommand forSpec context: presenterIntance);
		register: (DTRerunATestCommand forSpec context: presenterIntance) beHiddenWhenCantBeRun;
		register: (DTResultDebugCommand forSpec context: presenterIntance) beHiddenWhenCantBeRun;
		beDisplayedAsGroup;
		yourself
]

{ #category : #api }
DTTestsRunner >> debugTest: aDTRerunConfiguration [
	| selector partialResult oldResult |
	selector := aDTRerunConfiguration testToReRun selector.
	(aDTRerunConfiguration testToReRun class selector: selector) debug.
	partialResult := (self runForConfiguration: aDTRerunConfiguration)
		testsResult.
	oldResult := self
		removeTest: aDTRerunConfiguration testToReRun
		from: aDTRerunConfiguration previousResult testsResult.
	^ DTTestsRunnerResult new
		testsResult: (self joinTestResult: oldResult with: partialResult);
		yourself
]

{ #category : #api }
DTTestsRunner >> firstListLabel [
	^ 'Packages'
]

{ #category : #api }
DTTestsRunner >> handleReRunResult: rerunnedResult forConfiguration: aDTRerunConfiguration [
	| oldResult |
	oldResult := self
		removeTest: aDTRerunConfiguration testToReRun
		from: aDTRerunConfiguration previousResult testsResult.
	^ DTTestsRunnerResult new
		testsResult: (self joinTestResult: oldResult with: rerunnedResult testsResult);
		yourself
]

{ #category : #tests }
DTTestsRunner >> hasExtraResultCommands [
	^ true
]

{ #category : #private }
DTTestsRunner >> joinTestResult: aTestResult with: partialResult [
	| newResult |
	newResult := aTestResult.
	partialResult passed do: [ :each | newResult addPass: each ].
	partialResult errors do: [ :each | newResult addError: each ].
	partialResult failures do: [ :each | newResult addFailure: each ].
	partialResult skipped do: [ :each | newResult addSkip: each ].
	^ newResult
]

{ #category : #tests }
DTTestsRunner >> label: aString forSuite: aTestSuite [
	^ String streamContents: [ :stream |
		stream nextPutAll: 'Running '; print: aTestSuite tests size; space; nextPutAll: aString.
		aTestSuite tests size > 1 ifTrue: [ stream nextPut: $s ] ]. 
]

{ #category : #api }
DTTestsRunner >> reRunPlugin: aSymbol with: aDTRerunConfiguration [
	^ self perform: aSymbol with: aDTRerunConfiguration
]

{ #category : #private }
DTTestsRunner >> removeTest: aTest from: aTestResult [
	aTestResult
		instVarNamed: 'passed'
		put: (aTestResult passed copyWithout: aTest).
	aTestResult
		instVarNamed: 'failures'
		put: (aTestResult failures copyWithout: aTest).
	aTestResult
		instVarNamed: 'errors'
		put: (aTestResult errors copyWithout: aTest).
	^ aTestResult
]

{ #category : #api }
DTTestsRunner >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestsRunner >> runErrors: aDTTestsRunnerResult [
	| oldResult failuresResult |
	oldResult := aDTTestsRunnerResult.
	failuresResult := self
		runTestSuites:
			(self testSuiteOf: oldResult testsResult errors withName: 'errors').
	oldResult testsResult instVarNamed: 'errors' put: OrderedCollection new.
	oldResult
		testsResult: (self joinTestResult: oldResult testsResult with: failuresResult).
	^ oldResult
]

{ #category : #api }
DTTestsRunner >> runFailures: aDTTestsRunnerResult [
	| oldResult failuresResult |
	oldResult := aDTTestsRunnerResult.
	failuresResult := self
		runTestSuites:
			(self testSuiteOf: oldResult testsResult failures withName: 'failures').
	oldResult testsResult instVarNamed: 'failures' put: Set new.
	oldResult
		testsResult: (self joinTestResult: oldResult testsResult with: failuresResult).
	^ oldResult
]

{ #category : #api }
DTTestsRunner >> runForConfiguration: aDTpluginConfiguration [
	| results |
	results := DTTestsRunnerResult new
		testsResult: (self runTestSuites: { aDTpluginConfiguration asTestSuite });
		yourself.
	^ aDTpluginConfiguration handleResults: results for: self
]

{ #category : #private }
DTTestsRunner >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		when: TestAnnouncement
		do: [ :testAnnouncement | 
			self announcer
				announce:
					(DTStatusUpdate
						message: ('Running test {1}.' format: {testAnnouncement test name})) ].
	[ aTestSuite run: aResult ]
		ensure: [ aTestSuite unsubscribe: TestAnnouncement ]
]

{ #category : #api }
DTTestsRunner >> runTest: aDTRerunConfiguration [
	| partialResult oldResult |
	partialResult := (self runForConfiguration: aDTRerunConfiguration)
		testsResult.
	oldResult := self
		removeTest: aDTRerunConfiguration testToReRun
		from: aDTRerunConfiguration previousResult testsResult.
	^ DTTestsRunnerResult new
		testsResult: (self joinTestResult: oldResult with: partialResult);
		yourself
]

{ #category : #private }
DTTestsRunner >> runTestSuites: testSuites [ 
	|result|
	result := TestAsserter classForTestResult new.
	CurrentExecutionEnvironment runTestsBy: [
		testSuites
			do: [:testSuite | self runSuite: testSuite withResult: result ]
			displayingProgress: 'Running Tests'
	].
	^ result
]

{ #category : #api }
DTTestsRunner >> secondListLabel [
	^ 'Tests Cases'
]

{ #category : #api }
DTTestsRunner >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTTestsRunner >> startButtonLabel [
	^ 'Run Tests' translated
]

{ #category : #tests }
DTTestsRunner >> testSuiteOf: aSetOfTest withName: aString [
	^ aSetOfTest
		collect: [ :each | 
			TestSuite new
				in: [ :suite | 
					suite
						addTest: each;
						name: (self label: aString forSuite: suite) ];
				yourself ]
]
