Class {
	#name : #CmRerunATestCommand,
	#superclass : #CmLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
CmRerunATestCommand >> execute [
	self drTest reRunPlugin: #runTest:
]

{ #category : #hooks }
CmRerunATestCommand >> initialize [
	super initialize.
	self basicName: 'Re-run test'
]
