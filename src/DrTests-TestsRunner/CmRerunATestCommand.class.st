Class {
	#name : #CmRerunATestCommand,
	#superclass : #CmLeafResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
CmRerunATestCommand >> execute [
	self drTest runPluginFor: (self plugin buildReRunConfigurationFrom: self drTest)
]

{ #category : #hooks }
CmRerunATestCommand >> initialize [
	super initialize.
	self basicName: 'Re-run test'
]
