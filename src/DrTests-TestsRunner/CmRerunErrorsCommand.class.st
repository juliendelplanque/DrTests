Class {
	#name : #CmRerunErrorsCommand,
	#superclass : #CmResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #hooks }
CmRerunErrorsCommand >> execute [
	self context runPluginMethod: #runErrors:
]

{ #category : #hooks }
CmRerunErrorsCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Errors'
]
