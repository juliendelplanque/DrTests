Class {
	#name : #DTCommentToTest,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-CommentsToTests'
}

{ #category : #'api - accessing' }
DTCommentToTest class >> pluginName [
	"The name of the plugin to be displayed in DrTests UI."
	^ 'Comment to test'
]

{ #category : #'api - accessing' }
DTCommentToTest class >> weight [
	"The lighter is a plugin, the higher it is displayed in the drop list for plugin selection."
	^ 10
]

{ #category : #api }
DTCommentToTest >> createResults [
	| results cmdConf |
	cmdConf := DTCommentTestConfiguration
		items: self ui testsConfiguration items.
	"testClasses from the UI to create a DTCommentTestConf"
	results := (self runTestSuites: {cmdConf asTestSuite})
		asResultsForDrTests.
	results subResults
		do: [ :resultGroup | 
			resultGroup
				contextMenuBlock: [ :menu | 
					menu
						addGroup: [ :group | 
							group
								addItem: [ :item | 
									item
										name: 'Re-run';
										action: [ "TODO: self reRunResultGroup: resultGroup" ] ] ] ] ].
	^ results
]

{ #category : #api }
DTCommentToTest >> itemsToBeAnalysedFor: packagesSelected [
	^ packagesSelected
		flatCollect: [ :p | 
			p definedClasses
				select: [ :c | 
					c methods
						anySatisfy: [ :m | 
							((m methodClass commentsAt: m selector)
								select: [ :com | com includesSubstring: '>>>' ]) isNotEmpty ] ] ]
]

{ #category : #api }
DTCommentToTest >> packagesAvailableForAnalysis [
	^ RPackage organizer packages
		select: [ :p | 
			p definedClasses
				anySatisfy: [ :c | 
					c methods
						anySatisfy: [ :m | 
							m comment isNotNil
								and: [ ((m methodClass commentsAt: m selector)
										select: [ :com | com includesSubstring: '>>>' ]) isNotEmpty ] ] ] ]
]

{ #category : #api }
DTCommentToTest >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTCommentToTest >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTCommentToTest >> runForConfiguration: aDTpluginConfiguration [
	| results cmdConf |
	cmdConf := DTCommentTestConfiguration
		items: aDTpluginConfiguration items.	
	results := (self runTestSuites: {cmdConf asTestSuite})
		asResultsForDrTests.
	results subResults
		do: [ :resultGroup | 
			resultGroup
				contextMenuBlock: [ :menu | 
					menu
						addGroup: [ :group | 
							group
								addItem: [ :item | 
									item
										name: 'Re-run';
										action: [ "TODO: self reRunResultGroup: resultGroup" ] ] ] ] ].
	^ results
]

{ #category : #api }
DTCommentToTest >> runSuite: aTestSuite withResult: aResult [
	aTestSuite
		subscribe: TestAnnouncement
		do: [ :testAnnouncement | 
			self ui
				updateStatus: 'Running test {1}.'
				format: {testAnnouncement test asString} ].
	[ aTestSuite run: aResult ]
		ensure: [ aTestSuite unsubscribe: TestAnnouncement ]
]

{ #category : #api }
DTCommentToTest >> runTestSuites: testSuites [
	| result |
	result := TestAsserter classForTestResult new.
	CurrentExecutionEnvironment
		runTestsBy: [ testSuites
				do: [ :testSuite | self runSuite: testSuite withResult: result ]
				displayingProgress: 'Running Tests' ].
	^ result
]

{ #category : #api }
DTCommentToTest >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTCommentToTest >> startButtonLabel [
	^ 'Run Tests' translated
]
