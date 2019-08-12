Class {
	#name : #DTDynamicResultDebugCommand,
	#superclass : #DTLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #initialization }
DTDynamicResultDebugCommand >> execute [
	self drTest reRunPlugin: #debugTest:
]

{ #category : #initialization }
DTDynamicResultDebugCommand >> initialize [
	super initialize.
	self basicName: 'Debug test'
]
