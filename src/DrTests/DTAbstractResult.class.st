Class {
	#name : #DTAbstractResult,
	#superclass : #Object,
	#category : #DrTests
}

{ #category : #accessing }
DTAbstractResult >> drTestsName [
	"Returns the name to display for this object in DrTestsUI."
	^ self subclassResponsibility
]

{ #category : #accessing }
DTAbstractResult >> subResults [
	^ #()
]
