Class {
	#name : #DTDRerunGroupOfResultCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTDRerunGroupOfResultCommand >> canBeRun [
	^ self context resultSelected class = DTTreeNode
]

{ #category : #hooks }
DTDRerunGroupOfResultCommand >> execute [
	self drTest runPluginFor: (self plugin buildReRunConfigurationFrom: self drTest)
]

{ #category : #hooks }
DTDRerunGroupOfResultCommand >> initialize [
	super initialize.
	self basicName: 'Re-run tests'
]
