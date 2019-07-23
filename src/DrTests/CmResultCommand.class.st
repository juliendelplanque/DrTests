Class {
	#name : #CmResultCommand,
	#superclass : #CmCommand,
	#category : #DrTests
}

{ #category : #accessing }
CmResultCommand >> drTest [
	^ self context
]

{ #category : #hooks }
CmResultCommand >> resultSelected [
	^ self drTest resultSelected
]
