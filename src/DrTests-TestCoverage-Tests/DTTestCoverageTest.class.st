Class {
	#name : #DTTestCoverageTest,
	#superclass : #TestCase,
	#instVars : [
		'plugin',
		'dTconf',
		'package'
	],
	#category : #'DrTests-TestCoverage-Tests'
}

{ #category : #running }
DTTestCoverageTest >> setUp [
	super setUp.
	package := RPackage organizer
		packageNamed: 'DrTests-TestCoverage-MocksForTests'.
	"The test classes are in the same package as classes under test."
	dTconf := DTPluginConfiguration items: {package} packages: {package}.
	plugin := DTTestCoverage new
]

{ #category : #running }
DTTestCoverageTest >> testCoveragePercentForMock [
	| result |
	result := plugin runForConfiguration: dTconf.
	self assert: result percent closeTo: 50
]

{ #category : #running }
DTTestCoverageTest >> testCoverageResultIsAnInstanceOfDTTestCoverageResult [
| result|
result := plugin runForConfiguration: dTconf .
self assert: (result isKindOf: DTTestCoverageResult).

]

{ #category : #running }
DTTestCoverageTest >> testDTTestCoverageResultAsResultForDrTests [
	| items |
	items := plugin packagesAvailableForAnalysis.
	self assert: (items anyOne name includesSubstring: 'Tests')
]

{ #category : #running }
DTTestCoverageTest >> testDTTestCoverageResultBuildTreeForUIContainsNodes [
	| resultTree |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	self
		assert:
			(resultTree subResults
				allSatisfy: [ :subResult | subResult isKindOf: DTTreeNode ])
]

{ #category : #running }
DTTestCoverageTest >> testDTTestCoverageResultHas2Nodes [
	| resultTree |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	self assert: resultTree subResults size equals: 2
]

{ #category : #running }
DTTestCoverageTest >> testDTTestCoverageResultTheFirstNodeIsPercent [
	| resultTree |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	self
		assert:
			((resultTree subResults at: 1) name
				includesSubstring: '% Code Coverage')
]

{ #category : #running }
DTTestCoverageTest >> testDTTestCoverageResultTheSecondNodeSubResultsAreLeafs [
	| resultTree leafs |
	resultTree := (plugin runForConfiguration: dTconf) buildTreeForUI.
	leafs := resultTree subResults at: 2.
	self
		assert:
			(leafs subResults
				allSatisfy: [ :subResult | subResult isKindOf: DTTreeLeaf ])
]

{ #category : #running }
DTTestCoverageTest >> testItemsAvailableInTestCoveragePlugin [
	| items |
	items := plugin itemsToBeAnalysedFor: package.
	self deny: (items anyOne name includesSubstring: 'Tests')
]

{ #category : #running }
DTTestCoverageTest >> testNotExecutedMethodList [
	| result notExecutedMethodList |
	result := plugin runForConfiguration: dTconf.
	notExecutedMethodList := {(MockForCoverage >> #method2ForMock:)}.
	self
		assert:
			(notExecutedMethodList
				allSatisfy: [ :expectedNotExecutedMethod | 
					result methodList
						anySatisfy: [ :anyMethod | 
							anyMethod methodClass = expectedNotExecutedMethod methodClass
								and: [ anyMethod selector = expectedNotExecutedMethod selector ] ] ])
]

{ #category : #running }
DTTestCoverageTest >> testPackagesAvailableInTestCoveragePlugin [
	| items |
	items := plugin packagesAvailableForAnalysis.
	self assert: (items anyOne name includesSubstring: 'Tests')
]
