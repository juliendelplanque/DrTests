Class {
	#name : #DTRottenTestsResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'rottenTestsSet'
	],
	#category : #'DrTests-RottenTests'
}

{ #category : #accessing }
DTRottenTestsResult >> buildTreeForUI [
	^ DTTreeNode new
		name: 'Rotten tests';
		subResults: (self rottenTestsSet rottenTests collect: #asResultForDrTest);
		yourself
]

{ #category : #accessing }
DTRottenTestsResult >> rottenTestsSet [
	^ rottenTestsSet
]

{ #category : #accessing }
DTRottenTestsResult >> rottenTestsSet: anObject [
	rottenTestsSet := anObject
]
