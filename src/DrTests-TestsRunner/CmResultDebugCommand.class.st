Class {
	#name : #CmResultDebugCommand,
	#superclass : #CmLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #initialization }
CmResultDebugCommand >> execute [
	self drTest reRunPlugin: #debugTest:
]

{ #category : #initialization }
CmResultDebugCommand >> initialize [
	super initialize.
	self basicName: 'Debug test'
]
