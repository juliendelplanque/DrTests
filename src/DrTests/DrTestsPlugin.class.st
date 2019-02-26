Class {
	#name : #DrTestsPlugin,
	#superclass : #Object,
	#instVars : [
		'ui'
	],
	#category : #DrTests
}

{ #category : #'api - plugins' }
DrTestsPlugin class >> availablePlugins [
	^ (self allSubclasses reject: #isAbstract)
			sort: [ :a :b | a weight < b weight ]
]

{ #category : #testing }
DrTestsPlugin class >> isAbstract [
	"Should return true if the plugin is abstract and should not be instantiated."
	^ false
]

{ #category : #'api - accessing' }
DrTestsPlugin class >> pluginIcon [
	^ self iconNamed: #blank
]

{ #category : #'api - accessing' }
DrTestsPlugin class >> pluginName [
	"The name of the plugin to be displayed in DrTests UI."
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
DrTestsPlugin class >> weight [
	"The lighter is a plugin, the higher it is displayed in the drop list for plugin selection."
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> pluginName [
	^ self class pluginName
]

{ #category : #api }
DrTestsPlugin >> resultButtonAction [
	^ [ self ui browseSelectedResult ]
]

{ #category : #api }
DrTestsPlugin >> resultButtonHelp [
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> resultButtonLabel [
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> run [
	self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> selectClasesFrom: packagesSelected [
^ (packagesSelected collect: [ :p | 
		p definedClasses select: [ :c | c allSuperclasses includes: TestCase ] ])
]

{ #category : #api }
DrTestsPlugin >> selectPackages [
^(RPackage organizer packages select: [ :p |
			p definedClasses anySatisfy: [ :c | c allSuperclasses includes: TestCase ] ])
]

{ #category : #api }
DrTestsPlugin >> startButtonBlock [
	^ [ self run ]
]

{ #category : #api }
DrTestsPlugin >> startButtonHelp [
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> startButtonLabel [
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> title [
	^ self pluginName
]

{ #category : #api }
DrTestsPlugin >> ui [
	^ ui
]

{ #category : #api }
DrTestsPlugin >> ui: anObject [
	ui := anObject
]

{ #category : #'api - ui callbacks' }
DrTestsPlugin >> uiInitialized [
	self ui
		startButtonLabel: self startButtonLabel;
		startButtonHelp: self startButtonHelp;
		startButtonAction: self startButtonBlock;
		resultButtonLabel: self resultButtonLabel;
		resultButtonHelp: self resultButtonHelp;
		resultButtonAction: self resultButtonAction;
		title: self title;
		updateStatus: (self pluginName , ' plugin is ready to work!' translated);
		updatePackagesList.
]
