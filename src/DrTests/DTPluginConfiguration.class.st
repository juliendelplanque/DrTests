"
I hold the information that would be used by a DrTestPlugin.
"
Class {
	#name : #DTPluginConfiguration,
	#superclass : #Object,
	#instVars : [
		'items',
		'packagesSelected',
		'testSuite'
	],
	#category : #DrTests
}

{ #category : #tests }
DTPluginConfiguration class >> items: aCollectionOfClasses [
	^ self new
		items: aCollectionOfClasses;
		yourself
]

{ #category : #tests }
DTPluginConfiguration class >> items: aCollectionOfClasses packages: aCollectionOfPackages [
	^ self new
		items: aCollectionOfClasses;
		packagesSelected: aCollectionOfPackages;
		yourself.
]

{ #category : #converting }
DTPluginConfiguration >> asTestSuite [
	testSuite := TestSuite new.
	self items
		reject: #isAbstract
		thenDo: [ :s | testSuite addTest: s suite ].
	^ testSuite
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
DTPluginConfiguration >> packagesSelected [
	^ packagesSelected
]

{ #category : #accessing }
DTPluginConfiguration >> packagesSelected: packages [
	packagesSelected := packages
]

{ #category : #accessing }
DTPluginConfiguration >> testSuite [
	^ testSuite
]

{ #category : #accessing }
DTPluginConfiguration >> testSuite: anObject [
	testSuite := anObject
]
