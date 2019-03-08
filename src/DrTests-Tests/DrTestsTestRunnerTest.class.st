Class {
	#name : #DrTestsTestRunnerTest,
	#superclass : #TestCase,
	#instVars : [
		'plugin'
	],
	#category : #'DrTests-Tests'
}

{ #category : #tests }
DrTestsTestRunnerTest >> setUp [

	super setUp.
	plugin := DTTestsRunner new
]

{ #category : #tests }
DrTestsTestRunnerTest >> testAllSelectedClassesAreTestCases [

	| package |
	package := plugin packagesAvailableForAnalysis anyOne.
	self assert: ((plugin selectClasesFrom: {package}) flattened allSatisfy: [ :each | each isTestCase ])
]

{ #category : #tests }
DrTestsTestRunnerTest >> testSelectedPackagesContainTestCases [

	self assert: (plugin packagesAvailableForAnalysis allSatisfy: [ :package |
		package definedClasses anySatisfy: [ :class |
			class isTestCase ] ])
]
