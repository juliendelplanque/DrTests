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
DTRottenTestsPlugin >> convertToResultsForDrTests: aRottenTestsSet [ 
	^ DTTreeNode new
		subResults:
			{(DTTreeNode new
				name: 'Rotten tests';
				subResults: (aRottenTestsSet rottenTests collect: #asResultForDrTest);
				yourself)
			};
			yourself
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
DTRottenTestsPlugin >> runForConfiguration: aDTPluginConfiguration [
	[
		^ DTRottenTestsResult new
			rottenTestsSet: (RottenTestsFinder analyze: aDTPluginConfiguration asTestSuite);
			yourself
	] on: Warning, RTFTestAnalysed
	do: [ :resumableException |
			self announcer
				announce: (DTStatusUpdate message: ('Announcement: {1}.' format: {resumableException messageText})) .
			resumableException resume ]
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonHelp [
	^ 'Run the analysis to find rotten tests.' translated
]

{ #category : #api }
DTRottenTestsPlugin >> startButtonLabel [
	^ 'Find Rotten Tests' translated
]
