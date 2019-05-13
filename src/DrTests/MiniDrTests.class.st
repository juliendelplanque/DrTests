Class {
	#name : #MiniDrTests,
	#superclass : #AbstractDrTestsUI,
	#instVars : [
		'resultsList'
	],
	#category : #DrTests
}

{ #category : #specs }
MiniDrTests class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
					add: #helpButton;
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
	resultsList testsResult errors isEmpty
		ifFalse: [ ^ Color named: 'red' ].
	resultsList testsResult failures isEmpty
		ifFalse: [ ^ Color named: 'yellow' ].
	^ Color named: 'green'
]

{ #category : #initialization }
MiniDrTests >> initializeButtons [
	startButton := self newButton.
	startButton
		label: 'run';
		icon: (self iconNamed: #smallUpdate);
		color: (Color named: 'gray').
	switchButton := self newButton.
	switchButton
		icon: (self iconNamed: #tools);
		label: 'configuration'.
	helpButton := self newButton.
	helpButton icon: (self iconNamed: #help)
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
MiniDrTests >> resultsList [
	^ resultsList ifNil: [ DTTreeNode empty] 
]

{ #category : #accessing }
MiniDrTests >> resultsList: aResultGroup [
	resultsList := aResultGroup
]

{ #category : #accessing }
MiniDrTests >> runPlugin [
	[ | results |
	self lock.
	self updateStatus: 'Tests started.'.
	results := self currentPlugin
		runForConfiguration: self testsConfiguration.
	self resultsList: results.
	self updateStatus: 'Tests finished.'.
	self updateUI ]
		ensure: [ self unlock ]
]

{ #category : #accessing }
MiniDrTests >> switchUI [
	^ [ self application close.
	DrTests
		reloadConfiguration: testsConfiguration
		withResults: resultsList
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
	startButton label: resultsList testsResult asString
]
