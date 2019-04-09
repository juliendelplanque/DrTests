"
I have the results of a DrTestPlugin analysis listed in groups: 
-Errors
-Failures
-Skipped tests
-PAssed test
I am used in DrTestsUI to show the results in a orderly manner.
"
Class {
	#name : #DTTreeNode,
	#superclass : #DTAbstractTreeNode,
	#instVars : [
		'name',
		'subResults',
		'contextMenuBlock'
	],
	#category : #DrTests
}

{ #category : #'instance creation' }
DTTreeNode class >> empty [
	^ self new
		subResults: #();
		yourself
]

{ #category : #accessing }
DTTreeNode >> contextMenuBlock [
	^ contextMenuBlock
]

{ #category : #accessing }
DTTreeNode >> contextMenuBlock: anObject [
	contextMenuBlock := anObject
]

{ #category : #menu }
DTTreeNode >> drTestsBuildContextMenu: menu [
	self contextMenuBlock value: menu
]

{ #category : #accessing }
DTTreeNode >> drTestsName [
	^ String streamContents: [ :s |
		s
			<< self name;
			<< $(;
			<< self subResults size;
			<< $) ]
]

{ #category : #initialization }
DTTreeNode >> initialize [
	super initialize.
	self
		contextMenuBlock: [ :menu | ] "Does nothing by default."
]

{ #category : #accessing }
DTTreeNode >> name [
	^ name
]

{ #category : #accessing }
DTTreeNode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DTTreeNode >> subResults [
	^ subResults
]

{ #category : #accessing }
DTTreeNode >> subResults: anObject [
	subResults := anObject
]