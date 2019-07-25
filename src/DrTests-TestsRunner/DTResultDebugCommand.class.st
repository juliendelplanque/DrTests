Class {
	#name : #DTResultDebugCommand,
	#superclass : #DTLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #initialization }
DTResultDebugCommand >> execute [
	self drTest reRunPlugin: #debugTest:
]

{ #category : #initialization }
DTResultDebugCommand >> initialize [
	super initialize.
	self basicName: 'Debug test'
]
