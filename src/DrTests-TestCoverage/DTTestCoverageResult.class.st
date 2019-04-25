"
I build a tree with information: 
-percent of covered methods in the selected packages
-List of the uncovered methods
I am used in DrTestsUI to show the results in a orderly manner.
"
Class {
	#name : #DTTestCoverageResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'methodList',
		'percent'
	],
	#category : #'DrTests-TestCoverage'
}

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> buildTreeForUI [
	^ DTTreeNode new
	subResults: { (DTTreeNode new
				name: (percent asString ), '% Code Coverage';
				subResults: {};
				yourself).(
	DTTreeNode new
		name: 'Uncovered methods';
	subResults: (self methodList collect: #asResultForDrTest);
	yourself ). 
	}

]

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> methodList [
	^methodList
]

{ #category : #'as yet unclassified' }
DTTestCoverageResult >> methodList: aCollectionOfMethods [
methodList := aCollectionOfMethods
]

{ #category : #accessing }
DTTestCoverageResult >> percent [
	^ percent
]

{ #category : #accessing }
DTTestCoverageResult >> percent: anObject [
	percent := anObject
]
