"
I am an especial result for RottenTests
"
Class {
	#name : #DTTreeLeaf,
	#superclass : #DTAbstractTreeNode,
	#instVars : [
		'content'
	],
	#category : #DrTests
}

{ #category : #'instance creation' }
DTTreeLeaf class >> content: aRottenTest [ 
	^ self new
		content: aRottenTest;
		yourself
]

{ #category : #accessing }
DTTreeLeaf >> content [
	^ content
]

{ #category : #accessing }
DTTreeLeaf >> content: anObject [
	content := anObject
]

{ #category : #actions }
DTTreeLeaf >> drTestsBrowse [
	self content drTestsBrowse
]

{ #category : #menu }
DTTreeLeaf >> drTestsBuildContextMenu: menu [
	self content drTestsBuildContextMenu: menu
]

{ #category : #accessing }
DTTreeLeaf >> drTestsName [
	^ self content drTestsName
]
