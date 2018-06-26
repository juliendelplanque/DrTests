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
	^ String streamContents: [ :s |
		s
			<< self name;
			<< $(;
			<< self subResults size;
			<< $) ]
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
