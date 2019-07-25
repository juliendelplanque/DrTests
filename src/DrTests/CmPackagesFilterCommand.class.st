Class {
	#name : #CmPackagesFilterCommand,
	#superclass : #CmPackagesCommand,
	#category : #'DrTests-Commands'
}

{ #category : #hooks }
CmPackagesFilterCommand >> execute [
self context filterPackageList
]

{ #category : #hooks }
CmPackagesFilterCommand >> initialize [
	super initialize.
	self
		basicName: 'Filter'; 
		basicDescription: 'filter packages by name' 
]
