Class {
	#name : #DTDynamicRerunErrorsCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-TestsRunner'
}

{ #category : #deprecation }
DTDynamicRerunErrorsCommand class >> isDeprecated [
	^ true
]

{ #category : #hooks }
DTDynamicRerunErrorsCommand >> execute [
	self context runPluginMethod: #runErrors:
]

{ #category : #hooks }
DTDynamicRerunErrorsCommand >> initialize [
	super initialize.
	self basicName: 'Re-run Errors'
]
