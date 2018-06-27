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
DTRottenTestsPlugin class >> weight [
	^ 20
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonHelp [
	^ 'Browse the rotten test selected in the results list.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> resultButtonLabel [
	^ 'Browse test' translated
]

{ #category : #private }
DTRottenTestsPlugin >> startAnalysis [
	[
		self ui lock.
		self ui updateStatus: 'Analysis started.'.
		[
			[	
				|results|
				results := (RottenTestsFinder analyze: self ui testSuiteFromSelection).
				self ui results: results asResultsForDrTests.
			] on: Warning do: [ :warning |
				Transcript
					show: warning messageText;
					cr.
				warning resume ]
		] on: RTFTestAnalysed do: [ :notif |
			self ui updateStatus: 'Analyzed test: {1}' format: { notif compiledMethod printString }.
			notif resume ]. 
		
		self ui updateResultsListLabel.
		self ui updateStatus: 'Analysis finished.'.
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
