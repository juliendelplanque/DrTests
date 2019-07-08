Class {
	#name : #MiniDrTests,
	#superclass : #AbstractDrTestsUI,
	#instVars : [
		'resultsList',
		'pluginResult'
	],
	#category : #DrTests
}

{ #category : #specs }
MiniDrTests class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
					add: #helpButton
						expand: false
						fill: false
						padding: 1;
					add: #switchButton;
					yourself)
			expand: false
			fill: true
			padding: 1;
		add: #startButton;
		yourself
]

{ #category : #accessing }
MiniDrTests >> currentPlugin: anObject [
	currentPlugin := anObject
]

{ #category : #accessing }
MiniDrTests >> evaluateColor [
	^ pluginResult color
]

{ #category : #initialization }
MiniDrTests >> initializeButtons [
	super initializeButtons.
	startButton
		label: 'run';
		icon: (self iconNamed: #smallUpdate);
		color: (Color named: 'gray').

]

{ #category : #accessing }
MiniDrTests >> initializePresenter [
	self startButton action: [ self runPlugin ].
	self switchButton action: self switchUI
]

{ #category : #initialization }
MiniDrTests >> initializeWidgets [
	self initializeButtons
]

{ #category : #accessing }
MiniDrTests >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self title;
		initialExtent: 200 @ 200
]

{ #category : #accessing }
MiniDrTests >> pluginResult [
	^ pluginResult
]

{ #category : #accessing }
MiniDrTests >> pluginResult: anObject [
	pluginResult := anObject
]

{ #category : #accessing }
MiniDrTests >> runPlugin [
	[ | results |
	self lock.
	self updateStatus: 'Tests started.'.
	results := self currentPlugin
		runForConfiguration: self testsConfiguration.
	self pluginResult: results.
	self updateStatus: 'Tests finished.'.
	self updateUI ]
		ensure: [ self unlock ]
]

{ #category : #accessing }
MiniDrTests >> switchUI [
	^ [ self withWindowDo: [ :window | window close ].
	DrTests
		reloadConfiguration: testsConfiguration
		withResults: pluginResult
		andPlugin: currentPlugin ]
]

{ #category : #accessing }
MiniDrTests >> title [
	^ 'MiniDrTests - ' , currentPlugin pluginName
]

{ #category : #accessing }
MiniDrTests >> updateUI [
	self withWindowDo: [ :window | window title: self title ].
	startButton color: self evaluateColor.
	startButton label: pluginResult summarizeInfo
]
