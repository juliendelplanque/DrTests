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

{ #category : #accessing }
DTResult >> drTestsName [
	^ self content drTestsName
]
