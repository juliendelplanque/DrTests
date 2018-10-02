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

{ #category : #private }
DTTestsRunner >> reRunResultGroup: aDTResultGroup [
	self halt
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
DTTestsRunner >> run [
	self runTests
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
		
		results := (self runTestSuites: self ui testsConfiguration asTestSuite tests) asResultsForDrTests.
		results subResults do: [ :resultGroup |
			resultGroup contextMenuBlock: [ :menu |
				menu
					addGroup: [ :group |
						group addItem: [ :item |
							item
								name: 'Re-run';
								action: [ self reRunResultGroup: resultGroup ] ] ] ] ].
		self ui results: results.
		self ui updateStatus: 'Tests finished.'.
	] ensure: [ self ui unlock ]
]

{ #category : #api }
DTTestsRunner >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTTestsRunner >> startButtonLabel [
	^ 'Run Tests' translated
]
