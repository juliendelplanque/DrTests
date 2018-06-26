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
	currentPlugin := anObject.
	
	self currentPlugin
		ui: self;
		uiInitialized
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
		help: 'Select the plugin used by Dr Tests UI.';
		items: DrTestsPlugin availablePlugins;
		displayBlock: [ :pluginClass | pluginClass pluginName ];
		iconHolder: [ :pluginClass | pluginClass pluginIcon ];
		whenSelectedItemChanged: [ :pluginClass |
			self currentPlugin: pluginClass new ].
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
			node subResults ]";
		doubleClickAction: [ 
			self browseSelectedTest ];
		menu: [ :menu | self menuForSelectedResult: menu. menu ]".
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

{ #category : #'api - locking' }
DrTestsUI >> lock [
	"Lock the UI, once this method is called, the user is not able to click on buttons or lists anymore."
	self locked: false
]

{ #category : #'api - locking' }
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

{ #category : #api }
DrTestsUI >> results: aCollectionOfDTAbstractResults [
	self resultsList
		roots: aCollectionOfDTAbstractResults;
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

{ #category : #'api - locking' }
DrTestsUI >> subwidgetsToLock [
	^ { self packagesList. self classesList. self resultsList. self startButton. self browseButton }
]

{ #category : #api }
DrTestsUI >> testSuiteFromSelection [
	| suite |
	suite := TestSuite new.
	self classesSelected collect: #suite thenDo: [ :s |
		suite addTests: s tests ].
	^ suite
]

{ #category : #api }
DrTestsUI >> title: aString [
	super title: 'Dr Tests - ' translated , aString
]

{ #category : #'accessing - subwidgets' }
DrTestsUI >> toolbar [
	^ toolbar
]

{ #category : #'api - locking' }
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
				<< 'Results:' ])
]

{ #category : #api }
DrTestsUI >> updateStatus: aString [
	self statusLabel
		label: ('{1}: {2}' format: { self dateAndTimeString . aString })
]

{ #category : #api }
DrTestsUI >> updateStatus: aString format: aCollection [
	self updateStatus: (aString format: aCollection)
]

{ #category : #private }
DrTestsUI >> whenPackagesSelectionChanged: packagesSelected [
	classesList resetSelection.
	classesList items: (packagesSelected collect: [ :p | 
		p definedClasses select: [ :c | c allSuperclasses includes: TestCase ] ]) flattened.
	self updatePackagesListLabel
]
