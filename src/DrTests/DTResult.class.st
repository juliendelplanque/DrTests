Class {
	#name : #DTResult,
	#superclass : #DTAbstractResult,
	#instVars : [
		'content'
	],
	#category : #DrTests
}

{ #category : #'instance creation' }
DTResult class >> content: aRottenTest [ 
	^ self new
		content: aRottenTest;
		yourself
]

{ #category : #accessing }
DTResult >> content [
	^ content
]

{ #category : #accessing }
DTResult >> content: anObject [
	content := anObject
]

{ #category : #actions }
DTResult >> drTestsBrowse [
	self content drTestsBrowse
]

{ #category : #menu }
DTResult >> drTestsBuildContextMenu: menu [
	self content drTestsBuildContextMenu: menu
]

{ #category : #accessing }
DTResult >> drTestsName [
	^ self content drTestsName
]
