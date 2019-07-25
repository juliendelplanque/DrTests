Class {
	#name : #DTPackagesFilterCommand,
	#superclass : #DTPackagesCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
DTPackagesFilterCommand >> execute [
self context filterPackageList
]

{ #category : #hooks }
DTPackagesFilterCommand >> initialize [
	super initialize.
	self
		basicName: 'Filter'; 
		basicDescription: 'filter packages by name' 
]
