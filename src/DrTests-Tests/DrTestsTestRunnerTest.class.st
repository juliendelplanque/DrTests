"
A DrTestsUITest is a test class for testing the behavior of DrTests-TestRunner
"
Class {
	#name : #DrTestsTestRunnerTest,
	#superclass : #TestCase,
	#instVars : [
		'plugin',
		'package',
		'dTconf'
	],
	#category : #'DrTests-Tests'
}

{ #category : #tests }
DrTestsTestRunnerTest >> setUp [
	super setUp.
	package := RPackage organizer
		packageNamed: 'DrTests-TestCoverage-MocksForTests'.
	dTconf := DTPluginConfiguration
		items:
			({package}
				flatCollect:
					[ :p | p definedClasses select: [ :c | c allSuperclasses includes: TestCase ] ])
		packages: {package}.
	plugin := DTTestsRunner new
]

{ #category : #tests }
DrTestsTestRunnerTest >> testAllSelectedClassesAreTestCases [

	| package |
	package := plugin packagesAvailableForAnalysis anyOne.
	self assert: ((plugin itemsToBeAnalysedFor: {package}) flattened allSatisfy: [ :each | each isTestCase ])
]

{ #category : #tests }
DrTestsTestRunnerTest >> testRunResultBuildTreeForUI [
	self
		assert: (plugin runForConfiguration: dTconf) buildTreeForUI class
		equals: DTTreeNode 
]

{ #category : #tests }
DrTestsTestRunnerTest >> testRunResultIsDTTestRunnerResult [
	self
		assert: (plugin runForConfiguration: dTconf) class
		equals: DTTestsRunnerResult 
]

{ #category : #tests }
DrTestsTestRunnerTest >> testSelectedPackagesContainTestCases [

	self assert: (plugin packagesAvailableForAnalysis allSatisfy: [ :package |
		package definedClasses anySatisfy: [ :class |
			class isTestCase ] ])
]

{ #category : #tests }
DrTestsTestRunnerTest >> testTestResultIsNotEmpty [
	self
		deny: (plugin runForConfiguration: dTconf) testsResult passed isEmpty
]
