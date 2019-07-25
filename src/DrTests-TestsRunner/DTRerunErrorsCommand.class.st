Class {
	#name : #DTRerunErrorsCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
DTRerunErrorsCommand >> execute [
	self context runPluginMethod: #runErrors:
]

{ #category : #hooks }
DTRerunErrorsCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Errors'
]
