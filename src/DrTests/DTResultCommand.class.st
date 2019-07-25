Class {
	#name : #DTResultCommand,
	#superclass : #CmCommand,
	#category : #'DrTests-Commands'
}

{ #category : #accessing }
DTResultCommand >> drTest [
	^ self context
]

{ #category : #accessing }
DTResultCommand >> plugin [
	^ self drTest currentPlugin
]

{ #category : #hooks }
DTResultCommand >> resultSelected [
	^ self drTest resultSelected
]
