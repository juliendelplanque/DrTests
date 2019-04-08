Class {
	#name : #DTAbstractTreeNode,
	#superclass : #Object,
	#category : #DrTests
}

{ #category : #actions }
DTAbstractTreeNode >> drTestsBrowse [
	"Actions to perform in order to browse the result.
	 Does nothing by default."
]

{ #category : #menu }
DTAbstractTreeNode >> drTestsBuildContextMenu: menu [
	"Builds the contextual menu to display in DrTests results tree when a node of the tree is right-clicked.
	 Does nothing by default."
]

{ #category : #accessing }
DTAbstractTreeNode >> drTestsName [
	"Returns the name to display for this object in DrTestsUI."
	^ self subclassResponsibility
]

{ #category : #accessing }
DTAbstractTreeNode >> subResults [
	^ #()
]
