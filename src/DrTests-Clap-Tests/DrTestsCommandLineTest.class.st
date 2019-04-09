"
A DrTestsCommandLineTest is a test class for testing the behavior of DrTestsCommandLine
"
Class {
	#name : #DrTestsCommandLineTest,
	#superclass : #TestCase,
	#instVars : [
		'drTestsCommandLine'
	],
	#category : #'DrTests-Clap-Tests'
}

{ #category : #running }
DrTestsCommandLineTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	drTestsCommandLine := DrTestsCommandLine drTests
]

{ #category : #tests }
DrTestsCommandLineTest >> testTestsCoverage [
	| match |
	match := drTestsCommandLine match: #('drtests' 'coverage').
	
	self deny: match isMismatch.
	self flag: #TODO.
]

{ #category : #tests }
DrTestsCommandLineTest >> testTestsProfiler [
	| match |
	match := drTestsCommandLine match: #('drtests' 'profile').
	
	self deny: match isMismatch.
	self flag: #TODO.
]

{ #category : #tests }
DrTestsCommandLineTest >> testTestsRunner [
	| match |
	match := drTestsCommandLine match: #('drtests' 'runner').
	
	self deny: match isMismatch.
	self flag: #TODO.
]
