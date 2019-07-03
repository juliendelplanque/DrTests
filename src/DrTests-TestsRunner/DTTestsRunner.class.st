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

{ #category : #api }
DTTestsRunner >> firstListLabel [
	^ 'Packages'
]

{ #category : #'as yet unclassified' }
DTTestsRunner >> joinTestResult: aTestRunnerResult with: partialResult [
	"TestRunnerResult testsResult = 4 {} passed
partialResults = testResult = 4 {} "

	"1. por cada item en partial eliminar su eq en original
2. añadir los item en partial en el original
3. decolver el original"

	| newResult |
	newResult := aTestRunnerResult .
	partialResult testsResult passed
		do: [ :each | newResult addPass: each ].
	partialResult testsResult errors
		do: [ :each | newResult addError: each ].
	partialResult testsResult failures
		do: [ :each | newResult addFailure: each ].
	partialResult testsResult skipped
		do: [ :each | newResult addSkip: each ].
	^ newResult
]

{ #category : #api }
DTTestsRunner >> reRunForConfiguration: aDTRerunConfiguration [
	| partialResult oldResult|
	partialResult := self runForConfiguration: aDTRerunConfiguration.
	oldResult:=aDTRerunConfiguration
	"	removeTestsInTestResult: partialResult testsResult."
		removeTestsInTestResult.
	^ DTTestsRunnerResult new
		testsResult:
			(self
				joinTestResult: oldResult 
				with: partialResult);
		testSuite: aDTRerunConfiguration testSuite;
		yourself
]

{ #category : #api }
DTTestsRunner >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestsRunner >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTTestsRunner >> runForConfiguration: aDTpluginConfiguration [
	| results |
	results := DTTestsRunnerResult new
		testsResult: (self runTestSuites: aDTpluginConfiguration asTestSuite tests);
		testSuite: aDTpluginConfiguration testSuite;
		yourself.
	^ results
]

{ #category : #private }
DTTestsRunner >> runSuite: aTestSuite [
	self executeSuite: aTestSuite as: [ :aSuite :aResult | aSuite run: aResult ].
]

{ #category : #private }
DTTestsRunner >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		when: TestAnnouncement
		do: [ :testAnnouncement | 
			self announcer
				announce:
					(DTStatusUpdate
						message: ('Running test {1}.' format: {testAnnouncement test asString})) ].
	[ aTestSuite run: aResult ]
		ensure: [ aTestSuite unsubscribe: TestAnnouncement ]
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
