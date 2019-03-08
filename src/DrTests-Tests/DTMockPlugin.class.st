Class {
	#name : #DTMockPlugin,
	#superclass : #DrTestsPlugin,
	#instVars : [
		'hasBeenRun'
	],
	#category : #'DrTests-Tests'
}

{ #category : #'api - accessing' }
DTMockPlugin class >> pluginName [
	
	^ 'Mock plugin for test'
]

{ #category : #'api - accessing' }
DTMockPlugin class >> weight [
	^ 40
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
DTMockPlugin >> run [
	hasBeenRun := true.
	^ DTResultGroup new
		subResults: {};
		yourself
]

{ #category : #api }
DTMockPlugin >> runForConfiguration: aDRpluginConfiguration [
	hasBeenRun := true.
	^ DTResultGroup new
		subResults: {};
		yourself
]

{ #category : #api }
DTMockPlugin >> startButtonHelp [
	
	^ 'Help me!'
]

{ #category : #api }
DTMockPlugin >> startButtonLabel [
	
	^ 'Mock start'
]
