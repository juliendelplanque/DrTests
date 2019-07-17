Class {
	#name : #CmResultDebugCommand,
	#superclass : #CmResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #initialization }
CmResultDebugCommand >> execute [
	self context reRunPlugin: #debugTest:
]

{ #category : #initialization }
CmResultDebugCommand >> initialize [
	super initialize.
	self basicName: 'Debug test'
]
