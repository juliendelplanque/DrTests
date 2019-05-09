Class {
	#name : #AbstractDrTestsUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'testsConfiguration',
		'startButton',
		'currentPlugin',
		'switchButton',
		'helpButton'
	],
	#category : #DrTests
}

{ #category : #accessing }
AbstractDrTestsUI >> currentPlugin [
	^ currentPlugin
]

{ #category : #accessing }
AbstractDrTestsUI >> currentPlugin: anObject [
	"If a plugin was set before, unsubscribe first."
	currentPlugin ifNotNil: [ 
		currentPlugin announcer
			unsubscribe: self ].
	currentPlugin := anObject.
	
	currentPlugin announcer
		when: DTStatusUpdate send: #handlePluginStatusUpdate: to: self.
	
	self updateUI
]

{ #category : #'announcement handling' }
AbstractDrTestsUI >> handlePluginStatusUpdate: aDTStatusUpdate [
	self updateStatus: aDTStatusUpdate message
]

{ #category : #accessing }
AbstractDrTestsUI >> helpButton [
	^ helpButton
]

{ #category : #accessing }
AbstractDrTestsUI >> helpButton: anObject [
	helpButton := anObject
]

{ #category : #initialization }
AbstractDrTestsUI >> initializeButtons [
	startButton := self newButton.
	switchButton := self newButton.
	helpButton := self newButton.
]

{ #category : #initialization }
AbstractDrTestsUI >> initializeWidgets [
	self initializeButtons
]

{ #category : #'api - locking' }
AbstractDrTestsUI >> lock [
	"Lock the UI, once this method is called, the user is not able to click on buttons or lists anymore."
	self locked: false
]

{ #category : #'api - locking' }
AbstractDrTestsUI >> locked: aBoolean [
	"Lock or unlock widgets returned by #subwidgetsToLock depending on aBoolean."
	self subwidgetsToLock
		do: [ :subwidget | subwidget enabled: aBoolean ]
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> resultButtonAction: aBlock [
	"Does nothing on purpose."
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> resultButtonHelp: aString [
	"Does nothing on purpose."
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> resultButtonLabel: aString [
	"Does nothing on purpose."
]

{ #category : #'accessing - subwidgets' }
AbstractDrTestsUI >> startButton [
	^ startButton
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> startButtonAction: aBlock [
	self startButton action: aBlock
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> startButtonHelp: aString [
	self startButton help: aString
]

{ #category : #'api - subwidgets configuration' }
AbstractDrTestsUI >> startButtonLabel: aString [
	self startButton label: aString
]

{ #category : #'api - locking' }
AbstractDrTestsUI >> subwidgetsToLock [
	^ { self startButton }
]

{ #category : #accessing }
AbstractDrTestsUI >> switchButton [
	^ switchButton
]

{ #category : #accessing }
AbstractDrTestsUI >> switchButton: anObject [
	switchButton := anObject
]

{ #category : #accessing }
AbstractDrTestsUI >> testsConfiguration [
	^ testsConfiguration
]

{ #category : #accessing }
AbstractDrTestsUI >> testsConfiguration: anObject [
	testsConfiguration := anObject
]

{ #category : #'api - locking' }
AbstractDrTestsUI >> unlock [
	"Unlock the UI, once this method is called, the user is able to click on buttons or lists and to launch analysis."
	self locked: true
]

{ #category : #updating }
AbstractDrTestsUI >> updateStatus: aString [
	"Does nothing on purpose."
]

{ #category : #api }
AbstractDrTestsUI >> updateStatus: aString format: aCollection [
	self updateStatus: (aString format: aCollection)
]

{ #category : #accessing }
AbstractDrTestsUI >> updateUI [
	self
		startButtonLabel: self currentPlugin startButtonLabel;
		startButtonHelp: self currentPlugin startButtonHelp;
		resultButtonLabel: self currentPlugin resultButtonLabel;
		resultButtonHelp: self currentPlugin resultButtonHelp;
		title: self currentPlugin title;
		updateStatus: self currentPlugin pluginName , ' plugin is ready to work!' translated.
]
