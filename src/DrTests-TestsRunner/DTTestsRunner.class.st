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
DTTestsRunner >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestsRunner >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #private }
DTTestsRunner >> runSuite: aTestSuite [
	self executeSuite: aTestSuite as: [ :aSuite :aResult | aSuite run: aResult ].
]

{ #category : #private }
DTTestsRunner >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		subscribe: TestAnnouncement
		do: [ :testAnnouncement | self ui updateStatus: 'Running test {1}.' format: { testAnnouncement test asString } ].
	[ aTestSuite run: aResult  ] ensure: [
		aTestSuite unsubscribe:TestAnnouncement.
	].
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

{ #category : #private }
DTTestsRunner >> runTests [
	[
		|results|
		self ui lock.
		self ui updateStatus: 'Tests started.'.
		
		results := self runTestSuites: self ui testSuiteFromSelection tests.
		self ui results: results asResultsForDrTests.
		self ui updateResultsListLabel.
		self ui updateStatus: 'Tests finished.'.
	] ensure: [ self ui unlock ]
]

{ #category : #api }
DTTestsRunner >> startButtonBlock [
	^ [ self runTests ]
]

{ #category : #api }
DTTestsRunner >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTTestsRunner >> startButtonLabel [
	^ 'Run Tests' translated
]
