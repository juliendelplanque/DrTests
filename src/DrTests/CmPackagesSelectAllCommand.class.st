Class {
	#name : #CmPackagesSelectAllCommand,
	#superclass : #CmPackagesCommand,
	#category : #DrTests
}

{ #category : #hooks }
CmPackagesSelectAllCommand >> execute [
self context selectAllPackageList
]

{ #category : #hooks }
CmPackagesSelectAllCommand >> initialize [
	super initialize.
	self
		basicName: 'Select all'.
]
