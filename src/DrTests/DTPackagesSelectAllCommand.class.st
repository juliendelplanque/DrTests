Class {
	#name : #DTPackagesSelectAllCommand,
	#superclass : #DTPackagesCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
DTPackagesSelectAllCommand >> execute [
self context selectAllPackageList
]

{ #category : #hooks }
DTPackagesSelectAllCommand >> initialize [
	super initialize.
	self
		basicName: 'Select all'.
]
