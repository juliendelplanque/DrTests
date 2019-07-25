Class {
	#name : #CmLeafResultCommand,
	#superclass : #CmResultCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
CmLeafResultCommand >> canBeRun [
	^ self resultSelected class = DTTreeLeaf
]
