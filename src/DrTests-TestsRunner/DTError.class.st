"
I model the fact that a test generated an error.
"
Class {
	#name : #DTError,
	#superclass : #DTTestResultType,
	#category : #'DrTests-TestsRunner'
}

{ #category : #accessing }
DTError >> name [
	^ 'Error'
]
