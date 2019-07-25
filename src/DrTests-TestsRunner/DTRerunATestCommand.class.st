Class {
	#name : #DTRerunATestCommand,
	#superclass : #DTLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTRerunATestCommand >> execute [
	self drTest runPluginFor: (self plugin buildReRunConfigurationFrom: self drTest)
]

{ #category : #hooks }
DTRerunATestCommand >> initialize [
	super initialize.
	self basicName: 'Re-run test'
]
