"
I provide the ability to: 
* select a plugin to create/run tests
* select sets of items to analyze
* obtain a detailed log of the results 

UI Description 
___________ 

The droplist contains all the plugins available to start the analysis. 

My left-most pane lists all of the categories that contain items (could subclasses of TestCase, executable comments, etc.); Once items are selected, the items that can be analyzed appear in the pane to right.
The right-most pane shows the results in different groups, depends the plugin's analysis. 

Run and browse buttons behaviour are defined by the current plugin selected.


"
Class {
	#name : #DrTests,
	#superclass : #AbstractDrTestsUI,
	#instVars : [
		'pluginsDropList',
		'packagesList',
		'packagesListLabel',
		'classesListLabel',
		'resultsList',
		'toolbar',
		'statusLabel',
		'plugins',
		'itemsList',
		'itemsListLabel',
		'resultViewsDropList',
		'pluginResult',
		'resultLabel',
		'packagesFilterTextInput'
	],
	#category : #'DrTests-Spec'
}

{ #category : #'tools registry' }
DrTests class >> beDefaultTestRunner [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : #specs }
DrTests class >> buildCommandsGroupWith: presenterIntance forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildContextualPackageGroupWith: presenterIntance);
		register: (self buildResultGroupWith: presenterIntance)
]

{ #category : #specs }
DrTests class >> buildContextualPackageGroupWith: presenterIntance [
	^ (CmCommandGroup named: 'Package menu') asSpecGroup
		register: (self buildPackageGroupWith: presenterIntance);
		yourself
]

{ #category : #specs }
DrTests class >> buildPackageGroupWith: presenterIntance [
	^ (CmCommandGroup named: 'Package tools') asSpecGroup
		basicDescription: 'Commands related to packages list.';
		register: (DTPackagesFilterCommand forSpec context: presenterIntance);
		register: (DTPackagesSelectAllCommand forSpec context: presenterIntance);
		beDisplayedAsGroup;
		yourself
]

{ #category : #specs }
DrTests class >> buildResultGroupWith: presenterIntance [
	presenterIntance currentPlugin hasExtraResultCommands
		ifTrue: [ ^ (CmCommandGroup named: 'Results tools') asSpecGroup
				basicDescription: 'Commands related to result.';
				register: (DTResultBrowseCommand forSpec context: presenterIntance) beHiddenWhenCantBeRun;
				register:
					(presenterIntance currentPlugin
						buildContextualMenuGroupWith: presenterIntance)
						beDisplayedAsGroup;
				yourself ]
		ifFalse: [ ^ (CmCommandGroup named: 'Results tools') asSpecGroup
				basicDescription: 'Commands related to result.';
				register: (DTResultBrowseCommand forSpec context: presenterIntance);
				yourself ]
]

{ #category : #specs }
DrTests class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #pluginsDropList;
				add: #switchButton
					withConstraints: [ :constraints | constraints width: self buttonWidth ];
				add: #helpButton
					withConstraints: [ :constraints | constraints width: self buttonWidth ];
				yourself)
			withConstraints: [ :constraints | 
				constraints
					expand: false;
					height: self toolbarHeight ];
		add:
			(SpPanedLayout newHorizontal
				add:
					(SpPanedLayout newHorizontal
						add:
							(SpBoxLayout newVertical
								add: #packagesListLabel
									withConstraints: [ :constraints | constraints height: self labelHeight ];
								add: #packagesList;
								add: #packagesFilterTextInput
									withConstraints: [ :constraints | constraints height: self labelHeight ];
								yourself);
						add:
							(SpBoxLayout newVertical
								add: #itemsListLabel
									withConstraints: [ :constraints | constraints height: self labelHeight ];
								add: #itemsList;
								yourself);
						yourself);
				add:
					(SpBoxLayout newVertical
						add: #resultViewsDropList
							withConstraints: [ :constraints | constraints expand: false ];
						add: #resultLabel
							withConstraints: [ :constraints | constraints height: self labelHeight ];
						add: #resultsList;
						yourself);
				yourself);
		add: #startButton
			withConstraints: [ :constraints | constraints width: self buttonWidth ];
		yourself
]

{ #category : #'world menu' }
DrTests class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Dr Test')
		parent: #Tools;
		action: [ self open ];
		order: 20;
		keyText: 'o, u';
		help: 'Let you run and debug SUnit tests.';
		icon: self taskbarIcon.
	aBuilder withSeparatorAfter	
]

{ #category : #api }
DrTests class >> open [
	^ self new
		openWithSpec;
		yourself
]

{ #category : #'tools registry' }
DrTests class >> registerToolsOn: registry [

	"Add DrTests to registry to replace the old test runner." 
	registry register: self as: #testRunner
]

{ #category : #specs }
DrTests class >> reloadConfiguration: aDTPluginConfiguration withResults: aDTPluginResult andPlugin: aDTPlugin [
	self open
		updateStatus: 'Tests finished.';
		currentPlugin: aDTPlugin;
		testsConfiguration: aDTPluginConfiguration;
		updateWithPluginResult: aDTPluginResult
]

{ #category : #actions }
DrTests >> browseSelectedResult [
	self resultSelected content drTestsBrowse
]

{ #category : #private }
DrTests >> buildLabelString: nameOfItems numberOfItemsSelected: aInt [
	^ String
		streamContents: [ :s | 
			s
				<< nameOfItems;
				nextPut: $(;
				<< aInt asString;
				<< ' selected):' ]
]

{ #category : #'accessing - subwidgets' }
DrTests >> classesListLabel [
	^ classesListLabel
]

{ #category : #private }
DrTests >> dateAndTimeString [
	^ DateAndTime now asStringYMDHM
]

{ #category : #private }
DrTests >> filterList: aListPresenter withName: aString [
	aListPresenter
		unselectAll;
		items:
			(currentPlugin packagesAvailableForAnalysis
				select: [ :each | '*' , aString , '*' match: each name ])
]

{ #category : #accessing }
DrTests >> helpText [
	^ 'TODO'
]

{ #category : #initialization }
DrTests >> initializeButtons [
	super initializeButtons.
	switchButton disable.
]

{ #category : #initialization }
DrTests >> initializeItemsListAndLabel [
	itemsListLabel := self newLabel.
	itemsListLabel
		help:
			'Select the classes to analyze. Cmd+A or Ctrl+A to select all classes.'.
	itemsList := self newList.
	itemsList
		sortingBlock: #name ascending;
		displayBlock: [ :item | item name ];
		whenSelectionChangedDo: [ self whenItemsSelectionChanged: self selectedItems ];
		disableFilter;
		flag: #TODO;
		"Filtering is not working in actual Spec state, so we disable it."
			"itemFilterBlock: [ :item :string | '*' , string , '*' match: item contents ];"
			beMultipleSelection.
	packagesList
		whenSelectionChangedDo: [ self whenPackagesSelectionChanged: self packagesSelected ]
]

{ #category : #initialization }
DrTests >> initializePackagesListAndLabel [
	packagesListLabel := self newLabel.
	packagesListLabel
		help:
			'Select the packages to analyze. Cmd+A or Ctrl+A to select all packages.'.
	packagesList := self newList.
	packagesList
		sortingBlock: #name ascending;
		displayBlock: [ :package | package name ];
		beMultipleSelection;
		contextMenu: [ (self rootCommandsGroup / 'Package menu') beRoot asMenuPresenter ].
	packagesFilterTextInput := self newTextInput
		placeholder: 'Filter...';
		whenTextChangedDo: [ self filterList: packagesList withName:  packagesFilterTextInput text ]
]

{ #category : #initialization }
DrTests >> initializePluginsDropList [
	pluginsDropList := self newDropList.
	self pluginsDropList
		help: 'Select the plugin used by Dr Tests UI.';
		items: self plugins;
		displayBlock: [ :pluginClass | pluginClass pluginName ];
		iconBlock: [ :pluginClass | pluginClass pluginIcon ];
		whenSelectedItemChangedDo: [ :pluginClass | self currentPlugin: pluginClass new ]
]

{ #category : #initialization }
DrTests >> initializePresenter [
	super initializePresenter.
	self resultViewsDropList
		transmitTo: resultsList
		transform: [ :pragma | (pluginResult perform: pragma methodSelector) subResults ].
	self pluginsDropList selectedIndex: 1
]

{ #category : #initialization }
DrTests >> initializeResultViewsDropList [
	resultViewsDropList := self newDropList.
	self resultViewsDropList
		help: 'Select the different views for results';
		displayBlock: [ :prag | prag argumentAt: 1 ]
]

{ #category : #initialization }
DrTests >> initializeResultsTreeAndLabel [
	resultLabel := self newLabel label: 'Results:'.
	resultsList := self newTreeTable.
	resultsList
		addColumn: (SpStringTableColumn evaluated: #drTestsName);
		children: [ :node | node subResults ];
		contextMenu: [ (self rootCommandsGroup / 'Results tools') beRoot asMenuPresenter ]
]

{ #category : #initialization }
DrTests >> initializeWidgets [
	statusLabel := self newLabel.
	self
		initializePluginsDropList;
		initializeButtons;
		initializePackagesListAndLabel;
		initializeItemsListAndLabel;
		initializeResultsTreeAndLabel;
		initializeResultViewsDropList
]

{ #category : #initialization }
DrTests >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title:  self title;
		initialExtent: 700 @ 500;
		statusBar: statusLabel
]

{ #category : #'accessing - subwidgets' }
DrTests >> itemsList [
	^ itemsList
]

{ #category : #'accessing - subwidgets' }
DrTests >> itemsListLabel [
	^ itemsListLabel
]

{ #category : #private }
DrTests >> menuForSelectedResult: menu [
	self resultSelected ifNil: [ ^ self ].
	self resultSelected content drTestsBuildContextMenu: menu
]

{ #category : #accessing }
DrTests >> packagesFilterTextInput [
	^ packagesFilterTextInput
]

{ #category : #accessing }
DrTests >> packagesFilterTextInput: anObject [
	packagesFilterTextInput := anObject
]

{ #category : #'accessing - subwidgets' }
DrTests >> packagesList [
	^ packagesList
]

{ #category : #'accessing - subwidgets' }
DrTests >> packagesListLabel [
	^ packagesListLabel
]

{ #category : #private }
DrTests >> packagesSelected [
	^ self packagesList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #'accessing - subwidgets' }
DrTests >> pluginResult [
	^ pluginResult
]

{ #category : #'api - subwidgets configuration' }
DrTests >> pluginResult: anObject [
	pluginResult := anObject
]

{ #category : #accessing }
DrTests >> plugins [
	^ plugins ifNil: [ DrTestsPlugin availablePlugins ]
]

{ #category : #'accessing - subwidgets' }
DrTests >> pluginsDropList [
	^ pluginsDropList
]

{ #category : #api }
DrTests >> reRunPlugin: aSymbol [
	| newResult |
	[ self lock.
	self updateStatus: 'Tests started.'.
	newResult := self currentPlugin
		reRunPlugin: aSymbol
		with: (self currentPlugin buildReRunConfigurationFrom: self).
	self updateWithResults: newResult.
	self updateStatus: 'Tests finished.' ]
		ensure: [ self unlock ]
]

{ #category : #accessing }
DrTests >> resultItemSelected [
	^ self resultsList ifNil: [ #() ] ifNotNil: #selectedItem
]

{ #category : #accessing }
DrTests >> resultSelected [
	^ self resultsList selectedItem
]

{ #category : #api }
DrTests >> resultTree: aResultGroup [
	aResultGroup
		ifNotNil: [ self resultsList roots: aResultGroup subResults ]
]

{ #category : #'accessing - subwidgets' }
DrTests >> resultViewsDropList [
	^ resultViewsDropList
]

{ #category : #'api - subwidgets configuration' }
DrTests >> resultViewsDropList: anObject [
	resultViewsDropList:= anObject 
]

{ #category : #'accessing - subwidgets' }
DrTests >> resultsList [
	^ resultsList
]

{ #category : #api }
DrTests >> runPluginMethod: aSymbol [
	[ self lock.
	self updateStatus: 'Tests started.'.
	self
		updateWithResults: (self currentPlugin perform: aSymbol with: self pluginResult).
	self updateStatus: 'Tests finished.' ]
		ensure: [ self unlock ]
]

{ #category : #api }
DrTests >> selectAllPackageList [
	packagesList selectAll
]

{ #category : #private }
DrTests >> selectedItems [
	^ self itemsList selectedItems
]

{ #category : #'accessing model' }
DrTests >> setModelBeforeInitialization: aDomainObject [
	plugins := aDomainObject
]

{ #category : #'accessing - subwidgets' }
DrTests >> statusLabel [
	^ statusLabel
]

{ #category : #'api - locking' }
DrTests >> subwidgetsToLock [
	^ { self packagesList. self itemsList. self resultsList. self startButton }
]

{ #category : #'accessing - subwidgets' }
DrTests >> switchUI [
	super switchUI.
	(MiniDrTests new
		testsConfiguration: self testsConfiguration;
		currentPlugin: self currentPlugin;
		updateWithPluginResult:self pluginResult ;
		yourself) openWithSpec
]

{ #category : #accessing }
DrTests >> testsConfiguration [
	testsConfiguration := self currentPlugin buildConfigurationFrom: self.
	^ testsConfiguration
]

{ #category : #accessing }
DrTests >> testsConfiguration: aDTTestsConfiguration [
	self packagesList selectItems: aDTTestsConfiguration packagesSelected.
	self itemsList selectItems: aDTTestsConfiguration items
]

{ #category : #accessing }
DrTests >> title [
	^ 'Dr Tests - ' , currentPlugin pluginName
]

{ #category : #private }
DrTests >> updateItemsListLabel [
	self itemsListLabel
		label:
			(self
				buildLabelString: self currentPlugin secondListLabel
				numberOfItemsSelected: self selectedItems size)
]

{ #category : #private }
DrTests >> updatePackagesList [
	packagesList unselectAll.
	itemsList newEmptyModel.
	packagesList items: currentPlugin packagesAvailableForAnalysis.
	currentPlugin setSelectionModeOfPackageList: packagesList.
	currentPlugin setSelectionModeOfItemsList: itemsList
]

{ #category : #private }
DrTests >> updatePackagesListLabel [
	self packagesListLabel
		label:
			(self
				buildLabelString: self currentPlugin firstListLabel
				numberOfItemsSelected: self packagesSelected size)
]

{ #category : #api }
DrTests >> updateResultLabel [
	resultLabel
		label: 'Results: ■';
		color: pluginResult color
]

{ #category : #api }
DrTests >> updateResultViewsDropList: aPragmaKey [
	| newPragmas |
	newPragmas := (PragmaCollector
		filter: [ :prg | prg keyword = aPragmaKey ]) reset collected.
		
	self resultViewsDropList listItems = newPragmas ifTrue: [ ^ self ].
	
	self resultViewsDropList
		items: newPragmas;
		selectedIndex: 1
]

{ #category : #api }
DrTests >> updateStatus: aString [
	self statusLabel
		label: ('{1}: {2}' format: { self dateAndTimeString . aString }).

]

{ #category : #private }
DrTests >> updateSwitchButton: itemsSelected [
	currentPlugin allowMiniDrTests
		ifTrue: [ switchButton enabled: itemsSelected isNotEmpty ]
		ifFalse: switchButton disable
]

{ #category : #accessing }
DrTests >> updateUI [
	self
		startButtonLabel: self currentPlugin startButtonLabel;
		startButtonHelp: self currentPlugin startButtonHelp;
		updateStatus: self currentPlugin pluginName , ' plugin is ready to work!' translated.
	self withWindowDo: [ :window | window title: self title ].
	self packagesFilterTextInput text: ''.
	self updatePackagesList.
	self resultTree: DTTreeNode empty
]

{ #category : #api }
DrTests >> updateWithPluginResult: aPluginResult [
	aPluginResult ifNotNil: [ self updateWithResults: aPluginResult ]
]

{ #category : #api }
DrTests >> updateWithResults: results [
	pluginResult := results.
	self resultTree: pluginResult buildTreeForUI.
	self updateResultViewsDropList: pluginResult pragmaKey.
	self updateResultLabel.
	resultsList
		contextMenu: [ (self rootCommandsGroup / 'Results tools') beRoot asMenuPresenter ]
]

{ #category : #private }
DrTests >> whenItemsSelectionChanged: itemsSelected [
	self updateItemsListLabel.
	self updateSwitchButton: itemsSelected
]

{ #category : #private }
DrTests >> whenPackagesSelectionChanged: packagesSelected [
	itemsList
		items: (currentPlugin itemsToBeAnalysedFor: packagesSelected);
		selectAll.
	self updatePackagesListLabel
]
