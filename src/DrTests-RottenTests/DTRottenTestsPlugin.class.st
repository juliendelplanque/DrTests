Class {
	#name : #DTRottenTestsPlugin,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-RottenTests'
}

{ #category : #'api - accessing' }
DTRottenTestsPlugin class >> pluginName [
	^ 'Rotten Tests Finder'
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonAction [
	^ [ self halt ]
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonHelp [
	^ 'Browse the rotten test selected in the results list.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #api }
DTRottenTestsPlugin >> startAnalysis [
	[
		self ui lock.
		self ui updateStatus: ('Analysis started ({1}).' format: { self ui dateAndTimeString }).
	
		UIManager default informUserDuring: [ :bar |
			[
				[	
					|results|
					results := RottenTestsFinder analyze: self ui testSuiteFromSelection.
					self ui resultsList
						items: results rottenTests;
						resetSelection.
				] on: Warning do: [ :warning |
					Transcript
						show: warning messageText;
						cr.
					warning resume ]
			] on: RTFTestAnalysed do: [ :notif |
				bar label: ('Analyzing test: {1}' format: { notif compiledMethod printString }).
				notif resume ] ]. 
		
		self ui updateResultsListLabel.
		self ui updateStatus: ('Analysis finished ({1}).' format: { self ui dateAndTimeString }).
	] ensure: [ self ui unlock ]
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonBlock [
	^ [ self startAnalysis ]
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonHelp [
	^ 'Run the analysis to find rotten tests.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonLabel [
	^ 'Find Rotten Tests' translated
]
