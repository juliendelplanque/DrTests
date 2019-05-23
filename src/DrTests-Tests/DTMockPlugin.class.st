"
A Mock object used in test
"
Class {
	#name : #DTMockPlugin,
	#superclass : #DrTestsPlugin,
	#instVars : [
		'hasBeenRun'
	],
	#category : #'DrTests-Tests'
}

{ #category : #testing }
DTMockPlugin class >> isAbstract [
	^ self = DTMockPlugin
]

{ #category : #'api - accessing' }
DTMockPlugin class >> pluginName [
	
	^ 'Mock plugin for test'
]

{ #category : #'api - accessing' }
DTMockPlugin class >> weight [
	^ 40
]

{ #category : #accessing }
DTMockPlugin >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
DTMockPlugin >> hasBeenRun [
	^ hasBeenRun
]

{ #category : #api }
DTMockPlugin >> initialize [

	super initialize.
	hasBeenRun := false.
]

{ #category : #api }
DTMockPlugin >> packagesAvailableForAnalysis [
	"This is a seleciton only for tests"

	^ {self class package}
]

{ #category : #api }
DTMockPlugin >> resultButtonHelp [
	
	^ 'Result help?'
]

{ #category : #api }
DTMockPlugin >> resultButtonLabel [
	
	^ 'Result?'
]

{ #category : #api }
DTMockPlugin >> runForConfiguration: aDTpluginConfiguration [
	hasBeenRun := true.
	^ DTMockPluginResult new
]

{ #category : #api }
DTMockPlugin >> startButtonHelp [
	
	^ 'Help me!'
]

{ #category : #api }
DTMockPlugin >> startButtonLabel [
	
	^ 'Mock start'
]
