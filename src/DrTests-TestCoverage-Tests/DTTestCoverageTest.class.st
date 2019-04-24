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
DTTestCoverageTest >> testDTTestCoverageResultBuildTreeForUI [
	"here the package tests"
self flag: #TODO
"	| items |
	items := plugin packagesAvailableForAnalysis.
	self assert: (items anyOne name includesSubstring: 'Tests')"
]

{ #category : #running }
DTTestCoverageTest >> testItemsAvailableInTestCoveragePlugin [
	"here the non package tests"

	| items |
	items := plugin itemsToBeAnalysedFor: package.
	self deny: (items anyOne name includesSubstring: 'Tests').
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
	"here the package tests"

	| items |
	items := plugin packagesAvailableForAnalysis.
	self assert: (items anyOne name includesSubstring: 'Tests')
]
