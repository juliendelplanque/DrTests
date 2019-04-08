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
