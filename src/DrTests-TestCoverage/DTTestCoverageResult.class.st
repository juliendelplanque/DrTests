Class {
	#name : #DTTestCoverageResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'methodList',
		'message'
	],
	#category : #'DrTests-TestCoverage'
}

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> asResultForDrTest: aCollectionOfMethods [
	| leafs |
	leafs := methodList collect: [ :m | DTTreeLeaf content: m ].
	^ leafs
]

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> buildTreeForUI [
	^ DTTreeNode new
	subResults: { (
	DTTreeNode new
		name: 'Uncovered methods';
	subResults: (self methodList collect: #asResultForDrTest);
	yourself ). }

]

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> methodList [
^methodList
]

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> methodList: aCollectionOfMethods [
methodList := aCollectionOfMethods
]
