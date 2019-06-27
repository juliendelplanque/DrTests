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

	| originalResult |
	originalResult := aTestRunnerResult testsResult.
	partialResult passed
		do: [ :newRes | 
			originalResult passed
				reject: [ :oldRes | 
					newRes selector = oldRes selector ] ].
	partialResult passed do: [ :each | originalResult addPass: each ].
		partialResult errors
		do: [ :newRes | 
			originalResult errors
				reject: [ :oldRes | 
					newRes selector = oldRes selector ] ].
	partialResult errors do: [ :each | originalResult addPass: each ].
	
	^ originalResult
]

{ #category : #api }
DTTestsRunner >> reRunForConfiguration: aDTRerunConfiguration [
	| result partialResult |
	result := DTTestsRunnerResult new.
	partialResult := aDTRerunConfiguration testToReRun run.
	result
		testsResult:
			(self
				joinTestResult: aDTRerunConfiguration pluginResult
				with: partialResult);
		testSuite: aDTRerunConfiguration testSuite.
	^ result
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
