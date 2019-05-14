"
I am a DrTestPlugin.
I create tests from executable comments and run these tests.
"
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
DTCommentToTest >> itemsToBeAnalysedFor: packagesSelected [
	^ packagesSelected
		flatCollect: [ :p | 
			p definedClasses
				select: [ :c | 
					c methods
						anySatisfy: [ :m | 
							(m methodClass compiledMethodAt: m selector) comments
								anySatisfy: [ :com | com includesSubstring: '>>>' ] ] ] ]
]

{ #category : #api }
DTCommentToTest >> packagesAvailableForAnalysis [
	self flag: #TODO. "We changed this method to make it faster but now it does not find examples in other comments than the first one."
	^ RPackage organizer packages
		select: [ :package | 
			package definedClasses
				anySatisfy: [ :class | 
					class methods
						anySatisfy: [ :method | 
							method comment isNotNil and: [ method comment includesSubstring: '>>>' ]
								"and: [ ((class commentsAt: method selector)
										select: [ :com | com includesSubstring: '>>>' ]) isNotEmpty ]" ] ] ]
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
	results := DTCommentToTestResult new
					testsResult: (self runTestSuites: {cmdConf asTestSuite});
					yourself.
	^ results
]

{ #category : #api }
DTCommentToTest >> runSuite: aTestSuite withResult: aResult [
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
