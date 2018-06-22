Class {
	#name : #DrTestsPlugin,
	#superclass : #Object,
	#instVars : [
		'ui'
	],
	#category : #DrTests
}

{ #category : #'api - accessing' }
DrTestsPlugin class >> pluginName [
	"The name of the plugin to be displayed in DrTests UI."
	^ self subclassResponsibility
]

{ #category : #'api - ui callbacks' }
DrTestsPlugin >> startAnalysis [
	"Message sent when the user request the analysis to be performed from the UI."
	self subclassResponsibility
]

{ #category : #accessing }
DrTestsPlugin >> ui [
	^ ui
]

{ #category : #accessing }
DrTestsPlugin >> ui: anObject [
	ui := anObject
]

{ #category : #'api - ui callbacks' }
DrTestsPlugin >> uiInitialized [
	"Message sent once the UI is fully initialized.
	 It allows to perform actions just after the UI appeared to the user."
]
