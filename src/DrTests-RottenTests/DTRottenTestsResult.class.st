"
I build a list with the rottenTests.
I am used in DrTestsUI to show the results in a orderly manner.
"
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
	<dTRottenTestsResultTreeNamed: 'List of rotten tests'>
	^ DTTreeNode new
		name: 'Rotten tests';
		subResults: (self rottenTestsSet rottenTests collect: #asResultForDrTest);
		yourself
]

{ #category : #accessing }
DTRottenTestsResult >> pragmaKey [
	^ #'dTRottenTestsResultTreeNamed:'
]

{ #category : #accessing }
DTRottenTestsResult >> rottenTestsSet [
	^ rottenTestsSet
]

{ #category : #accessing }
DTRottenTestsResult >> rottenTestsSet: anObject [
	rottenTestsSet := anObject
]
