Class {
	#name : #DrTestsUI,
	#superclass : #ComposableModel,
	#instVars : [
		'pluginsDropList',
		'packagesList',
		'packagesListLabel',
		'classesList',
		'classesListLabel',
		'resultsList',
		'resultsListLabel',
		'startButton',
		'browseButton',
		'toolbar',
		'statusLabel',
		'currentPlugin'
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

{ #category : #accessing }
DrTestsUI class >> labelHeight [
	^ StandardFonts defaultFont height + 2
]

{ #category : #api }
DrTestsUI class >> open [
	^ self new
		openWithSpec
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> browseButton [
	^ browseButton
]

{ #category : #actions }
DrTestsUI >> browseSelectedTest [
	self resultSelected rtfBrowserBrowse
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> classesList [
	^ classesList
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> classesListLabel [
	^ classesListLabel
]

{ #category : #accessing }
DrTestsUI >> classesSelected [
	^ self classesList ifNil: [ #() ] ifNotNil: #selectedItems
]

{ #category : #accessing }
DrTestsUI >> currentPlugin [
	^ currentPlugin
]

{ #category : #accessing }
DrTestsUI >> currentPlugin: anObject [
	currentPlugin := anObject
]

{ #category : #private }
DrTestsUI >> dateAndTimeString [
	^ String streamContents: [ :stream |
		|dateAndTime|
		dateAndTime := DateAndTime now.
		dateAndTime printSeparateDateAndTimeOn: stream ]
]

{ #category : #accessing }
DrTestsUI >> helpText [
	^ 'RottenTestsFinder helps you to find rotten tests in your unit tests.

A rotten test is a test method that refers to one of the method in "asserting" protocol of TestAsserter in its source code but does not call it during the execution.

## Analyse your tests
To start the analysis, you must:
1. Select one or many packages in the left list of the UI.
2. Select one or many test classes from the selected packages in the center list of the UI (those selected test classes will be analyzed).
3. Click on the "Start analysis" button.
4. The rotten tests found by the analysis are available in the right list of the UI (double click on an entry of the list or select an entry and click the "Browse test" button to open the class browser on the rotten test).

## Using RTF from ST code
RottenTestsFinder can also be used without the UI part.

To do that, simply use the following code snippet:

```
RottenTestsFinder analyze: target
```

where `target` can either be a class inheriting from TestCase, an instance of TestCase or an instance of TestSuite.
'
]

{ #category : #initialization }
DrTestsUI >> initialize [
	super initialize.
	self pluginsDropList
		setSelectedIndex: 1
]

{ #category : #initialization }
DrTestsUI >> initializeButtons [
	startButton := self newButton.
	browseButton := self newButton
]

{ #category : #initialization }
DrTestsUI >> initializeClassesListAndLabel [
	classesListLabel := self newLabel.
	self updateClassesListLabel.
	classesListLabel help: 'Select the classes to analyze. Cmd+A or Ctrl+A to select all classes.'.
	
	classesList :=  self instantiate: FastTableModel.
	
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
	
	packagesList :=  self instantiate: FastTableModel.
	packagesList
		items: (RPackage organizer packages select: [ :p |
			p definedClasses anySatisfy: [ :c | c allSuperclasses includes: TestCase ] ]);
		sortingBlock: [ :a :b | a name < b name ];
		displayBlock: [ :package | package name ];
		beMultipleSelection.
]

{ #category : #initialization }
DrTestsUI >> initializePluginsDropList [
	pluginsDropList := self newDropList.
	
	self pluginsDropList
		items: DrTestsPlugin availablePlugins;
		displayBlock: [ :pluginClass | pluginClass pluginName ];
		iconHolder: [ :pluginClass | pluginClass pluginIcon ];
		whenSelectedItemChanged: [ :pluginClass |
			self currentPlugin: pluginClass new.
			self currentPlugin
				ui: self;
				uiInitialized ].
]

{ #category : #initialization }
DrTestsUI >> initializeResultsTreeAndLabel [
	resultsListLabel := self newLabel.
	self updateResultsListLabel.
	resultsListLabel help: 'The rotten tests found during latest analysis. Double click on a test to browse it in the class browser.'.
	
	resultsList := self instantiate: FastTableModel.
	
	resultsList
		displayBlock: [ :rottenTest |
			rottenTest rtfBrowserName ];
		doubleClickAction: [ 
			self browseSelectedTest ];
		sortingBlock: [ :a :b | a rtfBrowserName < b rtfBrowserName ];
		menu: [ :menu | self menuForSelectedResult: menu. menu ].
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
	self
		initializePackagesListAndLabel;
		initializeClassesListAndLabel;
		initializeResultsTreeAndLabel;
		initializeButtons.
	
	statusLabel := self newLabel.
	
	self initializeToolbar.
	self initializePluginsDropList
]

{ #category : #private }
DrTestsUI >> lock [
	"Lock the UI, once this method is called, the user is not able to click on buttons or lists anymore."
	self locked: false
]

{ #category : #private }
DrTestsUI >> locked: aBoolean [
	"Lock or unlock widgets returned by #subwidgetsToLock depending on aBoolean."
	self subwidgetsToLock
		do: [ :subwidget | subwidget enabled: aBoolean ]
]

{ #category : #private }
DrTestsUI >> menuForSelectedResult: menu [
	self resultSelected ifNil: [ ^ self ].
	
	self resultSelected
		rtfBuilderBuildContextMenu: menu
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

{ #category : #accessing }
DrTestsUI >> packagesSelected [
	^ self packagesList ifNil: [ #() ] ifNotNil: #selectedItems
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

{ #category : #'accessing - subwidgets' }
DrTestsUI >> resultsList [
	^ resultsList
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> resultsListLabel [
	^ resultsListLabel
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> startButton [
	^ startButton
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> startButtonAction: aBlock [
	self startButton action: aBlock
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> startButtonHelp: aString [
	self startButton help: aString
]

{ #category : #'api - subwidgets configuration' }
DrTestsUI >> startButtonLabel: aString [
	self startButton label: aString
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> statusLabel [
	^ statusLabel
]

{ #category : #private }
DrTestsUI >> subwidgetsToLock [
	^ { self packagesList. self classesList. self resultsList. self startButton. self browseButton }
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> toolbar [
	^ toolbar
]

{ #category : #private }
DrTestsUI >> unlock [
	"Unlock the UI, once this method is called, the user is able to click on buttons or lists and to launch analysis."
	self locked: true
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
		label: (String streamContents: [ :s |
			s
				<< 'Rotten tests (';
				<< (self resultsList ifNil: [ 0 ] ifNotNil: [ :list | list listItems size ]);
				<< '):' ])
]

{ #category : #private }
DrTestsUI >> updateStatus: aString [
	self statusLabel
		label: aString
]

{ #category : #private }
DrTestsUI >> whenPackagesSelectionChanged: packagesSelected [
	classesList resetSelection.
	classesList items: (packagesSelected collect: [ :p | 
		p definedClasses select: [ :c | c allSuperclasses includes: TestCase ] ]) flattened.
	self updatePackagesListLabel
]
