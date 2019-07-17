Class {
	#name : #CmRerunATestCommand,
	#superclass : #CmResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
CmRerunATestCommand >> execute [
	self context reRunPlugin: #runTest:
]

{ #category : #hooks }
CmRerunATestCommand >> initialize [
	super initialize.
	self basicName: 'Re-run test'
]
