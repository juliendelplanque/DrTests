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
DTTestsRunner >> joinTestResult: aTestResult with: partialResult [
	"TestRunnerResult testsResult = 4 {} passed
partialResults = testResult = 4 {} "

	"1. por cada item en partial eliminar su eq en original
2. añadir los item en partial en el original
3. decolver el original"

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
