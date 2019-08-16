Class {
	#name : #DTLeafResultCommand,
	#superclass : #DTResultCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
DTLeafResultCommand >> canBeRun [
	^ self resultSelected isLeaf
]
