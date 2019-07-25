"
I am the abstract superclass for all classes that are results of a plugin in DrTests.
"
Class {
	#name : #DTPluginResult,
	#superclass : #Object,
	#instVars : [
		'testSuite'
	],
	#category : #'DrTests-Model'
}

{ #category : #accessing }
DTPluginResult >> buildTreeForUI [
	^ self subclassResponsibility
]

{ #category : #accessing }
DTPluginResult >> color [
	^ Color named: 'gray'
]

{ #category : #accessing }
DTPluginResult >> summarizeInfo [
	"Text showed in miniDrTests with info of the result "

	^ self asString
]

{ #category : #accessing }
DTPluginResult >> testSuite [
	^ testSuite
]

{ #category : #accessing }
DTPluginResult >> testSuite: anObject [
	testSuite := anObject
]

{ #category : #accessing }
DTPluginResult >> theme [
	^ Smalltalk ui theme
]
