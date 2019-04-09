"
I am the abstract superclass for all classes that are results of a plugin in DrTests.
"
Class {
	#name : #DTPluginResult,
	#superclass : #Object,
	#category : #DrTests
}

{ #category : #accessing }
DTPluginResult >> buildTreeForUI [
	^ self subclassResponsibility
]
