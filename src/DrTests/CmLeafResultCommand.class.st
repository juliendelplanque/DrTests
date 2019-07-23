Class {
	#name : #CmLeafResultCommand,
	#superclass : #CmResultCommand,
	#category : #DrTests
}

{ #category : #hooks }
CmLeafResultCommand >> canBeRun [
	^ self resultSelected class = DTTreeLeaf
]
