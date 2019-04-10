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
DTTestCoverage >> addMethodsUnderTestIn: listOfPackages to: methods [
	listOfPackages
		reject: #isNil
		thenDo: [ :package | 
			package methodReferences
				reject: [ :method | 
					(#(#packageNamesUnderTest #classNamesNotUnderTest)
						includes: method selector)
						or: [ method compiledMethod isAbstract
								or: [ (method compiledMethod refersToLiteral: #ignoreForCoverage)
										or: [ method methodClass instanceSide allSuperclasses includes: TestCase ] ] ] ]
				thenDo: [ :method | methods add: method ] ]
]

{ #category : #api }
DTTestCoverage >> convertToResultsForDrTests: coverageResult [
	^ DTTreeNode new
]

{ #category : #api }
DTTestCoverage >> itemsToBeAnalysedFor: packagesSelected [
	^ RPackage organizer packages
]

{ #category : #api }
DTTestCoverage >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestCoverage >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTTestCoverage >> runCoverage: aDTpluginConfiguration [
	"in DTConf we have the TestPackageSelected and the (items)packagesSelected"

	| suite link methods testClasses|
	methods := aDTpluginConfiguration items.
		methods := OrderedCollection new.
	self 
		addMethodsUnderTestIn: aDTpluginConfiguration items 
		to: methods.
	"self excludeClassesNotUnderTestFrom: methods."
	testClasses:=  aDTpluginConfiguration packagesSelected flatCollect:[:p| p classes].
	suite := self suiteFor: testClasses .
	"resetResult;"
	link := MetaLink new
		selector: #tagExecuted;
		metaObject: #node.
	[ methods do: [ :meth | meth ast link: link ].
	[ self runTestSuites: {suite} ]
		ensure: [ link uninstall ] ] valueUnpreemptively.
	
	(methods reject: [ :each | each ast hasBeenExecuted ])
		ifEmpty: [ UIManager default
				inform: 'Congratulations. Your tests cover all code under analysis.' ]
		ifNotEmpty: [ :notExecutedMethods | 
			Smalltalk tools messageList
				browse: notExecutedMethods
				title:
					'Not Covered Code ('
						, (100 - (100 * notExecutedMethods size // methods size)) printString
						, '% Code Coverage)' ].
					
		"cleanup the annotations"				
	methods
		do: [ :each | each ast removeProperty: #tagExecuted ifAbsent: [  ] ]
]

{ #category : #api }
DTTestCoverage >> runForConfiguration: aDTpluginConfiguration [
	| results covConf |
	covConf := DTTestCoverageConfiguration
		items: aDTpluginConfiguration items.
	results := DTTestCoverageResult new
		testsResult: (self runCoverage: aDTpluginConfiguration);
		yourself.
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
						ifFalse: [ each addToSuiteFromSelectors: suite ] ].
			suite name: 'Test' ]
]
