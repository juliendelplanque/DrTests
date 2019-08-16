Class {
	#name : #DTRerunCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTRerunCommand >> execute [
	self drTest runPluginFor: (self plugin buildReRunConfigurationFrom: self drTest)
]

{ #category : #hooks }
DTRerunCommand >> initialize [
	super initialize.
	self basicName: 'Re-run tests'
]
