Class {
	#name : #DTDynamicRerunFailuresCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #deprecation }
DTDynamicRerunFailuresCommand class >> isDeprecated [
	^ true
]

{ #category : #hooks }
DTDynamicRerunFailuresCommand >> execute [
	self context runPluginMethod: #runFailures:
]

{ #category : #hooks }
DTDynamicRerunFailuresCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Failures'
]
