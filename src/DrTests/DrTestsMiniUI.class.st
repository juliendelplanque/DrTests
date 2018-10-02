Class {
	#name : #DrTestsMiniUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'testsConfiguration',
		'startButton',
		'currentPlugin'
	],
	#category : #DrTests
}

{ #category : #specs }
DrTestsMiniUI class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :mainCol | 
			mainCol
				newRow: #startButton ];
		yourself
]

{ #category : #api }
DrTestsMiniUI class >> open [
	^ self new
		openWithSpec;
		yourself
]

{ #category : #accessing }
DrTestsMiniUI >> currentPlugin [
	^ currentPlugin
]

{ #category : #accessing }
DrTestsMiniUI >> currentPlugin: anObject [
	currentPlugin := anObject.
	
	self currentPlugin
		ui: self;
		uiInitialized
]

{ #category : #initialization }
DrTestsMiniUI >> initializeButtons [
	startButton := self newButton.
]

{ #category : #initialization }
DrTestsMiniUI >> initializeWidgets [
	self initializeButtons
]

{ #category : #'api - locking' }
DrTestsMiniUI >> lock [
	"Lock the UI, once this method is called, the user is not able to click on buttons or lists anymore."
	self locked: false
]

{ #category : #'api - locking' }
DrTestsMiniUI >> locked: aBoolean [
	"Lock or unlock widgets returned by #subwidgetsToLock depending on aBoolean."
	self subwidgetsToLock
		do: [ :subwidget | subwidget enabled: aBoolean ]
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> resultButtonAction: aBlock [
	"Does nothing on purpose."
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> resultButtonHelp: aString [
	"Does nothing on purpose."
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> resultButtonLabel: aString [
	"Does nothing on purpose."
]

{ #category : #api }
DrTestsMiniUI >> results: results [
	self flag: #TODO
]

{ #category : #'accessing - subwidgets' }
DrTestsMiniUI >> startButton [
	^ startButton
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> startButtonAction: aBlock [
	self startButton action: aBlock
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> startButtonHelp: aString [
	self startButton help: aString
]

{ #category : #'api - subwidgets configuration' }
DrTestsMiniUI >> startButtonLabel: aString [
	self startButton label: aString
]

{ #category : #'api - locking' }
DrTestsMiniUI >> subwidgetsToLock [
	^ { self startButton }
]

{ #category : #accessing }
DrTestsMiniUI >> testsConfiguration [
	^ testsConfiguration
]

{ #category : #accessing }
DrTestsMiniUI >> testsConfiguration: anObject [
	testsConfiguration := anObject
]

{ #category : #'api - locking' }
DrTestsMiniUI >> unlock [
	"Unlock the UI, once this method is called, the user is able to click on buttons or lists and to launch analysis."
	self locked: true
]

{ #category : #updating }
DrTestsMiniUI >> updateStatus: aString [
	"Does nothing on purpose."
]

{ #category : #api }
DrTestsMiniUI >> updateStatus: aString format: aCollection [
	self updateStatus: (aString format: aCollection)
]
