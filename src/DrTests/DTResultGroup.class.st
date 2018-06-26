Class {
	#name : #DTResultGroup,
	#superclass : #DTAbstractResult,
	#instVars : [
		'name',
		'subResults'
	],
	#category : #DrTests
}

{ #category : #accessing }
DTResultGroup >> drTestsName [
	^ self name
]

{ #category : #accessing }
DTResultGroup >> name [
	^ name
]

{ #category : #accessing }
DTResultGroup >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DTResultGroup >> subResults [
	^ subResults
]

{ #category : #accessing }
DTResultGroup >> subResults: anObject [
	subResults := anObject
]
