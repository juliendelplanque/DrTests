Class {
	#name : #DTTestsConfiguration,
	#superclass : #Object,
	#instVars : [
		'testClasses'
	],
	#category : #DrTests
}

{ #category : #tests }
DTTestsConfiguration class >> testClasses: aCollectionOfClasses [
	^ self new
		testClasses: aCollectionOfClasses;
		yourself
]

{ #category : #converting }
DTTestsConfiguration >> asTestSuite [
	| suite |
	suite := TestSuite new.
	self testClasses reject: #isAbstract thenDo: [ :s |
		suite addTest: s suite ].
	^ suite
]

{ #category : #accessing }
DTTestsConfiguration >> packages [
	^ (self testClasses collect: #package) asSet
]

{ #category : #accessing }
DTTestsConfiguration >> testClasses [
	^ testClasses
]

{ #category : #accessing }
DTTestsConfiguration >> testClasses: anObject [
	testClasses := anObject
]
