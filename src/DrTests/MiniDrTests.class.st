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
add: (SpecBoxLayout newHorizontal 
add: #helpButton;

add: #switchButton;
yourself) expand: false fill: true padding: 1;
add:#startButton;
yourself.
]

{ #category : #initialization }
MiniDrTests >> initializeButtons [
	startButton := self newButton.
	startButton label: 'run';
	icon: (self iconNamed: #smallUpdate);
	color: (Color named: 'green') .
	
	switchButton := self newButton.
	switchButton icon: (self iconNamed: #tools).
	
	
	helpButton := self newButton.
	helpButton icon: (self iconNamed: #help).
]

{ #category : #accessing }
MiniDrTests >> initializePresenter [

	self startButton action: [ self runPlugin ].
	self switchButton action:  self switchUI  .
]

{ #category : #initialization }
MiniDrTests >> initializeWidgets [
self initializeButtons 
]

{ #category : #accessing }
MiniDrTests >> results: aResultGroup [
resultsList := aResultGroup 
]

{ #category : #accessing }
MiniDrTests >> resultsList [
	^ resultsList ifNil: [ ^ DTTreeNode new ] ifNotNil: [ resultsList ]
]

{ #category : #accessing }
MiniDrTests >> resultsList: anObject [
	resultsList := anObject
]

{ #category : #accessing }
MiniDrTests >> runPlugin [
	[ | results |
	self lock.
	self updateStatus: 'Tests started.'.
	results := self currentPlugin
		runForConfiguration: self testsConfiguration.
	self results: results .
	self updateStatus: 'Tests finished.' .
	Transcript show: 'Tests finished'; cr.
	Transcript show: results asString; cr.
	]
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
		self title: self currentPlugin title
		"here change the color of startButton"

]
