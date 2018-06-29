Class {
	#name : #DTResultGroup,
	#superclass : #DTAbstractResult,
	#instVars : [
		'name',
		'subResults',
		'contextMenuBlock'
	],
	#category : #DrTests
}

{ #category : #accessing }
DTResultGroup >> contextMenuBlock [
	^ contextMenuBlock
]

{ #category : #accessing }
DTResultGroup >> contextMenuBlock: anObject [
	contextMenuBlock := anObject
]

{ #category : #menu }
DTResultGroup >> drTestsBuildContextMenu: menu [
	self contextMenuBlock value: menu
]

{ #category : #accessing }
DTResultGroup >> drTestsName [
	^ String streamContents: [ :s |
		s
			<< self name;
			<< $(;
			<< self subResults size;
			<< $) ]
]

{ #category : #initialization }
DTResultGroup >> initialize [
	super initialize.
	self
		contextMenuBlock: [ :menu | ] "Does nothing by default."
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
