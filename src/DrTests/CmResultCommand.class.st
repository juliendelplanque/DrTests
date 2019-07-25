Class {
	#name : #CmResultCommand,
	#superclass : #CmCommand,
	#category : #'DrTests-Commands'
}

{ #category : #accessing }
CmResultCommand >> drTest [
	^ self context
]

{ #category : #accessing }
CmResultCommand >> plugin [
	^ self drTest currentPlugin
]

{ #category : #hooks }
CmResultCommand >> resultSelected [
	^ self drTest resultSelected
]
