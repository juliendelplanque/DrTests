"
I am a DrTestPlugin.
I show the time that takes execute the test and the result of the tests.
"
Class {
	#name : #DTTestsProfiling,
	#superclass : #DrTestsPlugin,
	#instVars : [
		'dataTestTime'
	],
	#category : #'DrTests-TestsProfiling'
}

{ #category : #'api - accessing' }
DTTestsProfiling class >> pluginName [
	^ 'Tests Profiler'
]

{ #category : #'api - accessing' }
DTTestsProfiling class >> weight [
 ^ 5
]

{ #category : #api }
DTTestsProfiling >> resultButtonHelp [
	^ 'Browse the test selected in the results list.' translated
]

{ #category : #api }
DTTestsProfiling >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTTestsProfiling >> runForConfiguration: aDTpluginConfiguration [
	| results profilerVisitor |
	profilerVisitor := DTTestsProfilerVisitor new.
	aDTpluginConfiguration asTestSuite
		acceptSUnitVisitor: profilerVisitor.
	results := DTTestsProfilingResult new
		testsResult: profilerVisitor profilingData;
		yourself.
	^ results
]

{ #category : #api }
DTTestsProfiling >> startButtonHelp [
	^ 'Run tests selected.' translated
]

{ #category : #api }
DTTestsProfiling >> startButtonLabel [
	^ 'Profile Tests' translated
]
