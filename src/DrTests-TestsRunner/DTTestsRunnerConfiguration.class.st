Class {
	#name : #DTTestsRunnerConfiguration,
	#superclass : #DTPluginConfiguration,
	#category : #'DrTests-TestsRunner'
}

{ #category : #converting }
DTTestsRunnerConfiguration >> asTestSuite [
	|newTestSuite|
	newTestSuite := TestSuite new.
	self items
		reject: #isAbstract
		thenDo: [ :item | newTestSuite addTest: item drTestsSuite "This method allows to either add a test or a test suite depending on kind of item." ].
	^ newTestSuite
]
