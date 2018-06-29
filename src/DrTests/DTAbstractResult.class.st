Class {
	#name : #DTAbstractResult,
	#superclass : #Object,
	#category : #DrTests
}

{ #category : #actions }
DTAbstractResult >> drTestsBrowse [
	"Actions to perform in order to browse the result.
	 Does nothing by default."
]

{ #category : #menu }
DTAbstractResult >> drTestsBuildContextMenu: menu [
	"Builds the contextual menu to display in DrTests results tree when a node of the tree is right-clicked.
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
