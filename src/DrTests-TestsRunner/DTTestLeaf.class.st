Class {
	#name : #DTTestLeaf,
	#superclass : #DTTreeLeaf,
	#instVars : [
		'type'
	],
	#category : #'DrTests-TestsRunner'
}

{ #category : #accessing }
DTTestLeaf >> type [
	^ type
]

{ #category : #accessing }
DTTestLeaf >> type: anObject [
	type := anObject
]
