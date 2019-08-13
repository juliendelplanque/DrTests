"
I am a Plugin used to execute an analysis

To run, I need a DTPluginConfiguration that contains the items I will analyse. I define the way to execute the analysis and create a result (could be a TestResult). 
"
Class {
	#name : #DrTestsPlugin,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'DrTests-Model'
}

{ #category : #'api - plugins' }
DrTestsPlugin class >> availablePlugins [
	^ (self allSubclasses reject: #isAbstract)
			sort: [ :a :b | a weight < b weight ]
]

{ #category : #'api - accessing' }
DrTestsPlugin class >> firstListLabel [
	"The name of the label in the first column"

	^ 'Packages'
]

{ #category : #testing }
DrTestsPlugin class >> isAbstract [
	"Should return true if the plugin is abstract and should not be instantiated."
	^ self = DrTestsPlugin
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
DrTestsPlugin >> allowMiniDrTests [
	^ false
]

{ #category : #accessing }
DrTestsPlugin >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'configuration building' }
DrTestsPlugin >> buildConfigurationFrom: aDrTests [
	"Builds a configuration from the plugin by reading the information held by the UI (aDrTests)."
	^ DTPluginConfiguration
		items: aDrTests selectedItems
		packages: aDrTests packagesSelected
]

{ #category : #api }
DrTestsPlugin >> buildContextualMenuGroupWith: presenterIntance [
]

{ #category : #'configuration building' }
DrTestsPlugin >> buildReRunConfigurationFrom: aDrTests [
	"Builds a configuration for the plugin by reading the information held by the UI (aDrTests) and the last value of results."

	^ DTReRunConfiguration new
		previousResult: aDrTests pluginResult;
		configurationToRun: (DTTestsRunnerConfiguration items: { aDrTests resultSelected content });
		yourself
]

{ #category : #accesing }
DrTestsPlugin >> firstListLabel [
	^ 'items'
]

{ #category : #'configuration building' }
DrTestsPlugin >> hasExtraResultCommands [
	^ false
]

{ #category : #api }
DrTestsPlugin >> itemsToBeAnalysedFor: packagesSelected [
	"This method returns the items to be analysed by the plugin.
	For most plugins it will be TestCases but some plugins will return other objects like comments."

	^ packagesSelected
		flatCollect:
			[ :p | p definedClasses select: [ :c | c allSuperclasses includes: TestCase ] ]
]

{ #category : #api }
DrTestsPlugin >> packagesAvailableForAnalysis [
	^ RPackage organizer packages
		select: [ :p | p definedClasses anySatisfy: [ :c | c isTestCase ] ]
]

{ #category : #api }
DrTestsPlugin >> pluginName [
	^ self class pluginName
]

{ #category : #api }
DrTestsPlugin >> reRunForConfiguration: aDTpluginConfiguration [
]

{ #category : #api }
DrTestsPlugin >> reRunPlugin: aSymbol with: aDTpluginConfiguration [
	self deprecated: 'Should not be used, meta-programming. Need to be removed.'.
]

{ #category : #api }
DrTestsPlugin >> resultButtonHelp [
	^ self subclassResponsibility
]

{ #category : #api }
DrTestsPlugin >> runForConfiguration: aDTpluginConfiguration [
	self subclassResponsibility
]

{ #category : #accesing }
DrTestsPlugin >> secondListLabel [
	^ 'items'
]

{ #category : #api }
DrTestsPlugin >> setSelectionModeOfItemsList: aListPresenter [
	aListPresenter beMultipleSelection
]

{ #category : #api }
DrTestsPlugin >> setSelectionModeOfPackageList: aListPresenter [
	aListPresenter beMultipleSelection
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
