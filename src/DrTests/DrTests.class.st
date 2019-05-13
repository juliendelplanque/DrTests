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
		'resultsListLabel',
		'browseButton',
		'toolbar',
		'statusLabel',
		'plugins',
		'itemsList',
		'itemsListLabel'
	],
	#category : #DrTests
}

{ #category : #specs }
DrTests class >> defaultSpec [
^ 	SpecBoxLayout newVertical 
		add:(SpecBoxLayout newHorizontal  
	add: #pluginsDropList;
	add: #switchButton;
	yourself) expand: false fill: true padding: 1;
		
		add: 
		(SpecPanedLayout newHorizontal
	add: ( SpecPanedLayout newHorizontal
		add: 
			(SpecBoxLayout newVertical
				add: #packagesListLabel
					withConstraints: [ :constraints | constraints height: self labelHeight ];
				add: #packagesList; 
				yourself);
		add:
			(SpecBoxLayout newVertical
				add: #itemsListLabel
					withConstraints: [ :constraints | constraints height: self labelHeight ];
				add: #itemsList;
				yourself);
				yourself);
		add:
			(SpecBoxLayout newVertical
				add: #resultsListLabel
					withConstraints: [ :constraints | constraints height: self labelHeight ];
				add: #resultsList;
				add: #browseButton
				expand: false fill: true padding: 1;
				yourself);
		
			yourself);
			
			add: #startButton expand: false fill: true padding: 3;
			add: #statusLabel expand: false fill: true padding: 1;
			yourself
]

{ #category : #api }
DrTests class >> open [
	^ self openWithExtent: 700@500
]

{ #category : #api }
DrTests class >> openWithExtent: extent [
	| toReturn window |
	toReturn := self new.
	window := toReturn openWithSpec.
	window extent: extent.
	^ toReturn
]

{ #category : #specs }
DrTests class >> reloadConfiguration: aDTPluginConfiguration withResults: aDTPluginResult andPlugin: aDTPlugin [
	self open
		testsConfiguration: aDTPluginConfiguration;
		updateStatus: 'Tests finished.';
		currentPlugin: aDTPlugin;
		results:  aDTPluginResult buildTreeForUI 
]

{ #category : #'accessing - subwidgets' }
DrTests >> browseButton [
	^ browseButton
]

{ #category : #actions }
DrTests >> browseSelectedResult [
	self resultSelected
		ifNotNil: [ :selected | selected content drTestsBrowse ]
]

{ #category : #'accessing - subwidgets' }
DrTests >> classesListLabel [
	^ classesListLabel
]

{ #category : #private }
DrTests >> classesSelected [
	^ self itemsList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #private }
DrTests >> dateAndTimeString [
	^ String streamContents: [ :stream |
		|dateAndTime|
		dateAndTime := DateAndTime now.
		stream
			<< dateAndTime asStringYMDHM ]
]

{ #category : #accessing }
DrTests >> helpText [
	^ 'TODO'
]

{ #category : #initialization }
DrTests >> initialize [
	super initialize.
	self pluginsDropList selectedIndex: 1
]

{ #category : #initialization }
DrTests >> initializeButtons [
	super initializeButtons.
	browseButton := self newButton.
	switchButton := self newButton.
	switchButton
		icon: (self iconNamed: #tools);
		label: 'switch';
		disable.
]

{ #category : #initialization }
DrTests >> initializeItemsListAndLabel [
	itemsListLabel := self newLabel.
	self updateItemsListLabel.
	itemsListLabel
		help:
			'Select the classes to analyze. Cmd+A or Ctrl+A to select all classes.'.
	itemsList := self newList.
	itemsList
		sortingBlock: [ :a :b | a name < b name ];
		whenSelectionChangedDo: [self whenItemsSelectionChanged: self itemsSelected  ];
		itemFilterBlock: [ :item :string | '*' , string , '*' match: item contents ];
		beMultipleSelection.
	packagesList
		whenSelectionChangedDo: [ self whenPackagesSelectionChanged: self packagesSelected ]
]

{ #category : #initialization }
DrTests >> initializePackagesListAndLabel [
	packagesListLabel := self newLabel.
	self updatePackagesListLabel.
	packagesListLabel
		help:
			'Select the packages to analyze. Cmd+A or Ctrl+A to select all packages.'.
	packagesList := self newList.
	packagesList
		sortingBlock: [ :a :b | a name < b name ];
		displayBlock: [ :package | package name ];
		itemFilterBlock: [ :item :string | '*' , string , '*' match: item contents ];
		beMultipleSelection
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
	self startButton action: [ self runPlugin ].
	self switchButton action: self switchUI
]

{ #category : #initialization }
DrTests >> initializeResultsTreeAndLabel [
	resultsListLabel := self newLabel.
	self updateResultsListLabel.
	resultsList := self newTreeTable.
	resultsList
		addColumn:
			(CompositeTableColumn new
				"title: 'title of the table';"
				addColumn:
					(ImageTableColumn new
						evaluated: [ :item | item drTestsName ];
						yourself);
				yourself);
		roots: {Object};
		children: [ :node | node subResults ];
		beResizable

]

{ #category : #initialization }
DrTests >> initializeWidgets [
	self initializeButtons.
	self
		initializePackagesListAndLabel;
		initializeItemsListAndLabel;
		initializeResultsTreeAndLabel.
	statusLabel := self newLabel.
	self initializePluginsDropList
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
DrTests >> itemsSelected [
	^ self itemsList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #private }
DrTests >> menuForSelectedResult: menu [
	self resultSelected ifNil: [ ^ self ].
	self resultSelected content drTestsBuildContextMenu: menu
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

{ #category : #initialization }
DrTests >> plugins [
	^ plugins ifNil: [ DrTestsPlugin availablePlugins ]
]

{ #category : #'accessing - subwidgets' }
DrTests >> pluginsDropList [
	^ pluginsDropList
]

{ #category : #'api - subwidgets configuration' }
DrTests >> resultButtonAction: aBlock [
	self browseButton action: aBlock
]

{ #category : #'api - subwidgets configuration' }
DrTests >> resultButtonHelp: aString [
	self browseButton help: aString
]

{ #category : #'api - subwidgets configuration' }
DrTests >> resultButtonLabel: aString [
	self browseButton label: aString
]

{ #category : #accessing }
DrTests >> resultSelected [
	^ self resultsList selectedItem
]

{ #category : #api }
DrTests >> results: aResultGroup [
 self resultsList roots: aResultGroup subResults 
]

{ #category : #'accessing - subwidgets' }
DrTests >> resultsList [
	^ resultsList
]

{ #category : #'accessing - subwidgets' }
DrTests >> resultsListLabel [
	^ resultsListLabel
]

{ #category : #initialization }
DrTests >> runPlugin [
	[ | results |
	self lock.
	self updateStatus: 'Tests started.'.
	results := self currentPlugin
		runForConfiguration: self testsConfiguration.
	self results: results buildTreeForUI.
	self updateStatus: 'Tests finished.' ]
		ensure: [ self unlock ]
]

{ #category : #initialization }
DrTests >> setModelBeforeInitialization: aDomainObject [
	plugins := aDomainObject
]

{ #category : #'accessing - subwidgets' }
DrTests >> statusLabel [
	^ statusLabel
]

{ #category : #'api - locking' }
DrTests >> subwidgetsToLock [
	^ { self packagesList. self itemsList. self resultsList. self startButton. self browseButton }
]

{ #category : #'accessing - subwidgets' }
DrTests >> switchUI [
	^ [ self application close.
	(MiniDrTests new
		testsConfiguration: self testsConfiguration;
		currentPlugin: self currentPlugin;
		yourself) openWithSpec ]
]

{ #category : #accessing }
DrTests >> testsConfiguration [
	^ DTPluginConfiguration
		items: self itemsSelected
		packages: self packagesSelected
]

{ #category : #accessing }
DrTests >> testsConfiguration: aDTTestsConfiguration [
	self packagesList model shownItems
		withIndexDo: [ :package :i | 
			(aDTTestsConfiguration packages includes: package)
				ifTrue: [ self packagesList setSelectionStateFor: i at: true ] ].
	self packagesList changed: #listElementAt:
]

{ #category : #api }
DrTests >> title: aString [
	super title: 'Dr Tests -' translated , aString.

]

{ #category : #private }
DrTests >> updateClassesListLabel [
	self classesListLabel
		label: (String streamContents: [ :s |
			s
				<< 'Items (';
				<< (self classesSelected size);
				<< ' selected):' ])
]

{ #category : #private }
DrTests >> updateItemsListLabel [
	self itemsListLabel
		label: (String streamContents: [ :s |
			s
				<< 'Items (';
				<< (self itemsSelected size asString );
				<< ' selected):' ])
]

{ #category : #private }
DrTests >> updatePackagesList [
	packagesList unselectAll.
	packagesList items: currentPlugin packagesAvailableForAnalysis
]

{ #category : #private }
DrTests >> updatePackagesListLabel [
	self packagesListLabel
		label: (String streamContents: [ :s |
			s
				<< 'Packages (';
				<< self packagesSelected size asString ;
				<< ' selected):' ])
]

{ #category : #private }
DrTests >> updateResultsListLabel [
	self resultsListLabel
		label: 'Results:'
]

{ #category : #api }
DrTests >> updateStatus: aString [
	self statusLabel
		label: ('{1}: {2}' format: { self dateAndTimeString . aString }).

]

{ #category : #private }
DrTests >> updateSwitchButton: itemsSelected [
	currentPlugin allowMiniDrTests
		ifTrue: [ itemsSelected isEmpty
				ifFalse: [ switchButton enable ]
				ifTrue: [ switchButton disable ] ]
		ifFalse: switchButton disable
]

{ #category : #accessing }
DrTests >> updateUI [
	self
		startButtonLabel: self currentPlugin startButtonLabel;
		startButtonHelp: self currentPlugin startButtonHelp;
		resultButtonLabel: self currentPlugin resultButtonLabel;
		resultButtonHelp: self currentPlugin resultButtonHelp;
		title: self currentPlugin title;
		updateStatus: self currentPlugin pluginName , ' plugin is ready to work!' translated.
	self resultButtonAction: [ self browseSelectedResult ].
	self updatePackagesList.
	self results: DTTreeNode empty
]

{ #category : #private }
DrTests >> whenItemsSelectionChanged: itemsSelected [
self updateItemsListLabel.
self updateSwitchButton:itemsSelected 
"allow minidrTEsts"

]

{ #category : #private }
DrTests >> whenPackagesSelectionChanged: packagesSelected [
	itemsList unselectAll.
	itemsList
		items: (currentPlugin itemsToBeAnalysedFor: packagesSelected).
	self updatePackagesListLabel
]
