Class {
	#name : #DTPluginConfiguration,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #DrTests
}

{ #category : #tests }
DTPluginConfiguration class >> items: aCollectionOfClasses [
	^ self new
		items: aCollectionOfClasses;
		yourself
]

{ #category : #converting }
DTPluginConfiguration >> asTestSuite [
	| suite |
	suite := TestSuite new.
	self items reject: #isAbstract thenDo: [ :s |
		suite addTest: s suite ].
	^ suite
]

{ #category : #accessing }
DTPluginConfiguration >> items [
	^ items
]

{ #category : #accessing }
DTPluginConfiguration >> items: anObject [
	items := anObject
]

{ #category : #accessing }
DTPluginConfiguration >> packages [
	^ (self items collect: #package) asSet
]
