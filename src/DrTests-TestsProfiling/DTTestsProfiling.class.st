Class {
	#name : #DTTestsProfiling,
	#superclass : #DrTestsPlugin,
	#instVars : [
		'dataTestTime'
	],
	#category : #'DrTests-TestsProfiling'
}

{ #category : #'api - accessing' }
DTTestsProfiling class >> pluginName [
	^ 'Tests Profiler'
]

{ #category : #'api - accessing' }
DTTestsProfiling class >> weight [
 ^ 5
]

{ #category : #api }
DTTestsProfiling >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestsProfiling >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTTestsProfiling >> runForConfiguration: aDTpluginConfiguration [
	| results profilerVisitor |
	profilerVisitor := DTTestsProfilerVisitor new.
	aDTpluginConfiguration asTestSuite
		acceptSUnitVisitor: profilerVisitor.
	results := DTTestsProfilingResult new
		testsResult: profilerVisitor profilingData;
		yourself.
	"	self halt."
	^ results
]

{ #category : #api }
DTTestsProfiling >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		subscribe: TestAnnouncement
		do: [ :testAnnouncement | 
			self announcer
				announce:
					(DTStatusUpdate
						message: ('Running test {1}.' format: {testAnnouncement test asString})) ].
	[ aTestSuite run: aResult ]
		ensure: [ aTestSuite unsubscribe: TestAnnouncement ]
]

{ #category : #api }
DTTestsProfiling >> runTestSuites: testSuites [ 
	|result |
	"save each testSuite in a dictionary"
	dataTestTime := Dictionary new.
	result := TestAsserter classForTestResult new.
	CurrentExecutionEnvironment runTestsBy: [
		testSuites
			do: [:testSuite | self runSuite: testSuite withResult: result ]
			"generate the pair in "
			displayingProgress: 'Running Tests'
	].
	^ result
]

{ #category : #api }
DTTestsProfiling >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTTestsProfiling >> startButtonLabel [
	^ 'Profile Tests' translated
]
