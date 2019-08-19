Class {
	#name : #DTRottenTestsPlugin,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-RottenTests'
}

{ #category : #'api - accessing' }
DTRottenTestsPlugin class >> pluginName [
	^ 'Rotten Tests Finder'
]

{ #category : #'api - accessing' }
DTRottenTestsPlugin class >> pluginResultClass [
	^ DTRottenTestsResult
]

{ #category : #'api - accessing' }
DTRottenTestsPlugin class >> weight [
	^ 20
]

{ #category : #api }
DTRottenTestsPlugin >> firstListLabel [
	^ 'Test Packages'
]

{ #category : #accessing }
DTRottenTestsPlugin >> pragmaForResultTrees [
	^ #'dTRottenTestsResultTreeNamed:'
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonHelp [
	^ 'Browse the rotten test selected in the results list.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> runForConfiguration: aDTPluginConfiguration [
	[ ^ self pluginResultClass new
		rottenTestsSet: (RottenTestsFinder analyze: aDTPluginConfiguration asTestSuite);
		yourself ]
		on: Warning , RTFTestAnalysed
		do: [ :resumableException | 
			self announcer
				announce:
					(DTStatusUpdate
						message: ('Announcement: {1}.' format: {resumableException messageText})).
			resumableException resume ]
]

{ #category : #api }
DTRottenTestsPlugin >> secondListLabel [
	^ 'Tests Cases'
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonHelp [
	^ 'Run the analysis to find rotten tests.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonLabel [
	^ 'Find Rotten Tests' translated
]
