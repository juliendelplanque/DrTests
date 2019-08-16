Class {
	#name : #DTTestLeaf,
	#superclass : #DTTreeLeaf,
	#instVars : [
		'type'
	],
	#category : #'DrTests-TestsRunner'
}

{ #category : #'instance creation' }
DTTestLeaf class >> content: anObject type: aTestResultType [
	^ (self content: anObject)
		type: aTestResultType;
		yourself
]

{ #category : #accessing }
DTTestLeaf >> type [
	^ type
]

{ #category : #accessing }
DTTestLeaf >> type: anObject [
	type := anObject
]
