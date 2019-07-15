Class {
	#name : #CmRerunFailuresCommand,
	#superclass : #CmResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
CmRerunFailuresCommand >> execute [
	self context runPluginMethod: #runFailures:
]

{ #category : #hooks }
CmRerunFailuresCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Failures'
]
