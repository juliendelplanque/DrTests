"
I model the fact that a test passed.
"
Class {
	#name : #DTPass,
	#superclass : #DTTestResultType,
	#category : #'DrTests-TestsRunner'
}

{ #category : #accessing }
DTPass >> name [
	^ 'Passing test'
]
