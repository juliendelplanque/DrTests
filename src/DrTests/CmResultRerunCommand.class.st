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
		basicName: 'Re-run'; 
		basicDescription: 'run this test again.' 
]
