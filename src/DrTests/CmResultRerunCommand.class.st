Class {
	#name : #CmResultRerunCommand,
	#superclass : #CmResultCommand,
	#category : #DrTests
}

{ #category : #hooks }
CmResultRerunCommand >> execute [
self context runResult
]

{ #category : #initialization }
CmResultRerunCommand >> initialize [
	super initialize.
	self
		basicName: 'Re-run2'; 
		basicDescription: 'run this test again.' 
]
