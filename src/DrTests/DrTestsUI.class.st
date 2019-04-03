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
	#name : #DrTestsUI,
	#superclass : #DrTestsMiniUI,
	#instVars : [
		'pluginsDropList',
		'packagesList',
		'packagesListLabel',
		'classesList',
		'classesListLabel',
		'resultsList',
		'resultsListLabel',
		'browseButton',
		'toolbar',
		'statusLabel',
		'plugins'
	],
	#category : #DrTests
}

{ #category : #specs }
DrTestsUI class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :mainCol | 
			mainCol
				newRow: [ :row |
					row
						add: #pluginsDropList;
						add: #toolbar ] height: self toolbarHeight;
				newRow: [ :row |
					row
						newColumn: [ :packagesColumn |
							packagesColumn
								add: #packagesListLabel height: self labelHeight;
								add: #packagesList ];
						addSplitter;
						newColumn: [ :classesColumn |
							 classesColumn
								add: #classesListLabel height: self labelHeight;
								add: #classesList ];
						addSplitter;
						newColumn: [ :resultsColumn |
							resultsColumn
								add: #resultsListLabel height: self labelHeight;
								add: #resultsList;
								add: #browseButton height: self buttonHeight ] ];
				newRow: #startButton height: self buttonHeight;
				newRow: #statusLabel height: self labelHeight ];
		yourself
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> browseButton [
	^ browseButton
]

{ #category : #actions }
DrTestsUI >> browseSelectedResult [
	self resultSelected
		ifNotNil: [ :selected | selected content drTestsBrowse ]
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> classesList [
	^ classesList
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> classesListLabel [
	^ classesListLabel
]

{ #category : #private }
DrTestsUI >> classesSelected [
	^ self classesList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #private }
DrTestsUI >> dateAndTimeString [
	^ String streamContents: [ :stream |
		|dateAndTime|
		dateAndTime := DateAndTime now.
		stream
			<< dateAndTime asStringYMDHM ]
]

{ #category : #accessing }
DrTestsUI >> helpText [
	^ 'TODO'
]

{ #category : #initialization }
DrTestsUI >> initialize [
	super initialize.
	self pluginsDropList
		setSelectedIndex: 1.
	
]

{ #category : #initialization }
DrTestsUI >> initializeButtons [
	super initializeButtons.
	browseButton := self newButton
]

{ #category : #initialization }
DrTestsUI >> initializeClassesListAndLabel [
	classesListLabel := self newLabel.
	self updateClassesListLabel.
	classesListLabel help: 'Select the classes to analyze. Cmd+A or Ctrl+A to select all classes.'.
	
	classesList :=  self newList.
	
	classesList
		sortingBlock: [ :a :b | a name < b name ];
		whenSelectionChanged: [ self updateClassesListLabel ];
		beMultipleSelection.
	
	packagesList whenSelectionChanged: [ 
		self whenPackagesSelectionChanged: self packagesSelected ].
]

{ #category : #initialization }
DrTestsUI >> initializePackagesListAndLabel [
	packagesListLabel := self newLabel.
	self updatePackagesListLabel.
	packagesListLabel help: 'Select the packages to analyze. Cmd+A or Ctrl+A to select all packages.'.
	
	packagesList :=  self newList.
	packagesList
		sortingBlock: [ :a :b | a name < b name ];
		displayBlock: [ :package | package name ];
		beMultipleSelection.
]

{ #category : #initialization }
DrTestsUI >> initializePluginsDropList [
	pluginsDropList := self newDropList.
	self pluginsDropList
		help: 'Select the plugin used by Dr Tests UI.';
		items: self plugins;
		displayBlock: [ :pluginClass | pluginClass pluginName ];
		iconHolder: [ :pluginClass | pluginClass pluginIcon ];
		whenSelectedItemChanged: [ :pluginClass | self currentPlugin: pluginClass new ]
]

{ #category : #initialization }
DrTestsUI >> initializePresenter [

	self startButton action: [ self runPlugin ]
]

{ #category : #initialization }
DrTestsUI >> initializeResultsTreeAndLabel [
	resultsListLabel := self newLabel.
	self updateResultsListLabel.
	
	resultsList := self newTree.
	
	resultsList
		displayBlock: [ :rottenTest |
			rottenTest drTestsName ];
		childrenBlock: [ :node |
			node subResults ];
		doubleClick: [ 
			self browseSelectedResult ];
		menu: [ :menu |
			self menuForSelectedResult: menu.
			menu ]
]

{ #category : #initialization }
DrTestsUI >> initializeToolbar [
	toolbar := MenuModel new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Help';
						icon: (self iconNamed: #glamorousHelp);
						action: [ self openHelp ] ] ].
	toolbar applyTo: self.
]

{ #category : #initialization }
DrTestsUI >> initializeWidgets [
	super initializeWidgets.
	self
		initializePackagesListAndLabel;
		initializeClassesListAndLabel;
		initializeResultsTreeAndLabel.
	
	statusLabel := self newLabel.
	
	self initializeToolbar.
	self initializePluginsDropList
]

{ #category : #private }
DrTestsUI >> menuForSelectedResult: menu [
	self resultSelected ifNil: [ ^ self ].
	
	self resultSelected content
		drTestsBuildContextMenu: menu
]

{ #category : #actions }
DrTestsUI >> openHelp [
	TextModel new
		enabled: false;
		title: 'Help';
		text: self helpText;
		openWithSpec
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> packagesList [
	^ packagesList
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> packagesListLabel [
	^ packagesListLabel
]

{ #category : #private }
DrTestsUI >> packagesSelected [
	^ self packagesList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #initialization }
DrTestsUI >> plugins [
	^ plugins ifNil: [ DrTestsPlugin availablePlugins ]
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> pluginsDropList [
	^ pluginsDropList
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> resultButtonAction: aBlock [
	self browseButton action: aBlock
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> resultButtonHelp: aString [
	self browseButton help: aString
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> resultButtonLabel: aString [
	self browseButton label: aString
]

{ #category : #accessing }
DrTestsUI >> resultSelected [
	^ self resultsList selectedItem
]

{ #category : #api }
DrTestsUI >> results: aResultGroup [
	self resultsList
		roots: aResultGroup subResults;
		resetSelection
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> resultsList [
	^ resultsList
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> resultsListLabel [
	^ resultsListLabel
]

{ #category : #initialization }
DrTestsUI >> runPlugin [
	[ | results |
	self lock.
	self updateStatus: 'Tests started.'.
	
	results := self currentPlugin
		runForConfiguration: self testsConfiguration.
	self results: results.	
	
	self updateStatus: 'Tests finished.' ]
		ensure: [ self unlock ]
		
]

{ #category : #initialization }
DrTestsUI >> setModelBeforeInitialization: aDomainObject [
	
	plugins := aDomainObject
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> statusLabel [
	^ statusLabel
]

{ #category : #'api - locking' }
DrTestsUI >> subwidgetsToLock [
	^ { self packagesList. self classesList. self resultsList. self startButton. self browseButton }
]

{ #category : #accessing }
DrTestsUI >> testsConfiguration [
	^ DTPluginConfiguration items: self classesSelected
]

{ #category : #accessing }
DrTestsUI >> testsConfiguration: aDTTestsConfiguration [
	self packagesList listItems withIndexDo: [ :package :i |
		(aDTTestsConfiguration packages includes: package)
			ifTrue: [ self packagesList setSelectionStateFor: i at: true ] ].
		
	self packagesList changed: #listElementAt:
]

{ #category : #api }
DrTestsUI >> title: aString [
	super title: 'Dr Tests - ' translated , aString
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> toolbar [
	^ toolbar
]

{ #category : #private }
DrTestsUI >> updateClassesListLabel [
	self classesListLabel
		label: (String streamContents: [ :s |
			s
				<< 'Test cases (';
				<< (self classesSelected size);
				<< ' selected):' ])
]

{ #category : #private }
DrTestsUI >> updatePackagesList [
	packagesList resetSelection.
	packagesList
		items: currentPlugin packagesAvailableForAnalysis
]

{ #category : #private }
DrTestsUI >> updatePackagesListLabel [
	self packagesListLabel
		label: (String streamContents: [ :s |
			s
				<< 'Packages (';
				<< self packagesSelected size;
				<< ' selected):' ])
]

{ #category : #private }
DrTestsUI >> updateResultsListLabel [
	self resultsListLabel
		label: 'Results:'
]

{ #category : #api }
DrTestsUI >> updateStatus: aString [
	self statusLabel
		label: ('{1}: {2}' format: { self dateAndTimeString . aString }).

]

{ #category : #accessing }
DrTestsUI >> updateUI [
	super updateUI.
	self resultButtonAction: [self browseSelectedResult].
	self updatePackagesList
]

{ #category : #private }
DrTestsUI >> whenPackagesSelectionChanged: packagesSelected [
	classesList resetSelection.
	classesList items: (currentPlugin itemsToBeAnalysedFor: packagesSelected). 
	self updatePackagesListLabel
]
