Class {
	#name : #DTRerunFailuresCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTRerunFailuresCommand >> execute [
	self context runPluginMethod: #runFailures:
]

{ #category : #hooks }
DTRerunFailuresCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Failures'
]
