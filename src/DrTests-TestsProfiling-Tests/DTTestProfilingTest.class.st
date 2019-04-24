Class {
	#name : #DTTestProfilingTest,
	#superclass : #TestCase,
	#instVars : [
		'package',
		'classes',
		'dTconf',
		'plugin'
	],
	#category : #'DrTests-TestsProfiling-Tests'
}

{ #category : #running }
DTTestProfilingTest >> setUp [
	super setUp.
	plugin := DTTestsProfiling  new.
	package := RPackage organizer
		packageNamed: 'DrTests-TestCoverage-MocksForTests'.
	classes := plugin itemsToBeAnalysedFor: {package}.
	dTconf := DTPluginConfiguration items: classes packages: {package}
]

{ #category : #running }
DTTestProfilingTest >> testCoverageResultIsAnInstanceOfDTTestProfilingResult [
| result|
result := plugin runForConfiguration: dTconf .
self assert: (result isKindOf: DTTestsProfilingResult).
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResulLeafsContentHaveATestCase [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 4.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult content testCase isKindOf: TestCase])
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResulLeafsContentHaveATestResult [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 4.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult content testResult isKindOf: TestResult ])
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResulLeafsContentHaveDuration [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 4.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult content duration isKindOf: Duration ])
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResultHas4Nodes [
	| resultTree |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	self assert: resultTree subResults size equals: 4
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResultTheSecondNodeSubResultsAreLeafs [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 3.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult  isKindOf: DTTreeLeaf  ])
]

{ #category : #running }
DTTestProfilingTest >> testDTTestCoverageResultTheThirdNodeSubResultsLeafsContentsAreDTTestCaseProfilingData [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 3.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult content isKindOf: DTTestCaseProfilingData  ])
]

{ #category : #running }
DTTestProfilingTest >> testItemsAvailableInTestProfilerPlugin [
	| items |
	items := plugin itemsToBeAnalysedFor: {package}.
	self assert: (items anyOne name includesSubstring: 'Test')
]