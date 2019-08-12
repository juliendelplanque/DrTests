Class {
	#name : #DTDynamicRerunFailuresCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTDynamicRerunFailuresCommand >> execute [
	self context runPluginMethod: #runFailures:
]

{ #category : #hooks }
DTDynamicRerunFailuresCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Failures'
]
