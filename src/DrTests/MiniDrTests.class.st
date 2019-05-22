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
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
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
		title: 'miniDrTests-' translated , currentPlugin pluginName;
		initialExtent: 300 @ 200
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
	^ [ self application close.
	DrTests
		reloadConfiguration: testsConfiguration
		withResults: pluginResult 
		andPlugin: currentPlugin ]
]

{ #category : #accessing }
MiniDrTests >> title: aString [
	super title: 'Dr Tests - ' translated , aString
]

{ #category : #accessing }
MiniDrTests >> updateUI [
	self title: self currentPlugin title.
	"here change the color of startButton"
	startButton color: self evaluateColor.
	startButton label: pluginResult summarizeInfo .
"	startButton label: resultsList testsResult asString"
]
