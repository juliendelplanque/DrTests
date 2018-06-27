Class {
	#name : #DTAbstractResult,
	#superclass : #Object,
	#category : #DrTests
}

{ #category : #actions }
DTAbstractResult >> drTestBrowse [
	"Actions to perform in order to browse the result.
	 Does nothing by default."
]

{ #category : #accessing }
DTAbstractResult >> drTestsName [
	"Returns the name to display for this object in DrTestsUI."
	^ self subclassResponsibility
]

{ #category : #accessing }
DTAbstractResult >> subResults [
	^ #()
]
