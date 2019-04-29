"
A Mock object used in test
"
Class {
	#name : #DTMockPluginResult,
	#superclass : #DTPluginResult,
	#category : #'DrTests-Tests'
}

{ #category : #accessing }
DTMockPluginResult >> buildTreeForUI [
	^ DTTreeNode new
		subResults: {};
		yourself
]
