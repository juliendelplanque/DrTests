"
A DrTestsUITest is a test class for testing the behavior of DrTestsUI
"
Class {
	#name : #DrTestsUITest,
	#superclass : #TestCase,
	#instVars : [
		'drTestsUI',
		'plugins',
		'plugin1',
		'plugin2'
	],
	#category : #'DrTests-Tests'
}

{ #category : #running }
DrTestsUITest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	plugin1 := DTTestsRunner.
	plugin2 := DTMockPlugin.
	plugins := {plugin1. plugin2}.
	drTestsUI := DrTestsUI on: plugins
]

{ #category : #tests }
DrTestsUITest >> testBrowseButton [
	
]

{ #category : #tests }
DrTestsUITest >> testClickButtonRunCallsPluginRun [

	drTestsUI pluginsDropList setSelectedItem: DTMockPlugin.
	
	drTestsUI startButton performAction.
	
	self assert: drTestsUI currentPlugin hasBeenRun
]

{ #category : #tests }
DrTestsUITest >> testCurrentPluginIsSelectedInDropDown [
	| currentPluginSelected  |
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	self
		assert: drTestsUI currentPlugin class
		equals: currentPluginSelected
]

{ #category : #tests }
DrTestsUITest >> testInitialPackagesAreInitialPluginPackages [

	self
		assertCollection: drTestsUI packagesList listItems
		hasSameElements: drTestsUI currentPlugin selectPackages
]

{ #category : #tests }
DrTestsUITest >> testInitialResultListIsEmpty [

	self assert: drTestsUI resultsList roots isEmpty
]

{ #category : #tests }
DrTestsUITest >> testInitialSelectedPluginIsFirstPluginInList [

	self assert: drTestsUI currentPlugin class equals: plugins first
]

{ #category : #tests }
DrTestsUITest >> testInitialWindowTitleIsInitialPluginWindowTitle [
	
	self
		assert: drTestsUI title
		equals: 'Dr Tests - ' , drTestsUI currentPlugin pluginName.
]

{ #category : #tests }
DrTestsUITest >> testMultipleSelectingPackagesWillUpdateTheClassesList [
	| currentPluginSelected randomPackage newPackagesSelected classesList packageSelected |
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	newPackagesSelected := OrderedCollection new.
	packageSelected := drTestsUI packagesList listItems anyOne.
	randomPackage := (drTestsUI packagesList listItems
		\ {packageSelected}) anyOne.
	newPackagesSelected add: packageSelected.
	newPackagesSelected add: randomPackage.
	drTestsUI whenPackagesSelectionChanged: newPackagesSelected.
	classesList := currentPluginSelected new
		selectClasesFrom: newPackagesSelected.
	self
		assertCollection: drTestsUI classesList listItems
		hasSameElements: classesList flattened


]

{ #category : #tests }
DrTestsUITest >> testNoPackageSelected [
	self
		assertCollection: drTestsUI classesList listItems
		hasSameElements: #()
]

{ #category : #tests }
DrTestsUITest >> testPluginsAreConfiguredPluginsOnly [
	self
		assert: drTestsUI pluginsDropList listItems asArray
		equals: plugins
]

{ #category : #tests }
DrTestsUITest >> testSelectingPackageWillUpdateTheClassesList [
	| newPackagesSelected |
	newPackagesSelected := {drTestsUI packagesList listItems anyOne}.
	drTestsUI whenPackagesSelectionChanged: newPackagesSelected.
	
	self
		assertCollection: drTestsUI classesList listItems
		hasSameElements: (drTestsUI currentPlugin selectClasesFrom: newPackagesSelected)
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdateCurrentPluginInstanceVariable [
	drTestsUI pluginsDropList setSelectedItem: plugin2.

	self assert: drTestsUI currentPlugin class equals: plugin2
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdatePackagesList [
	drTestsUI pluginsDropList setSelectedItem: plugin2.

	self
		assertCollection: drTestsUI packagesList listItems
		hasSameElements: drTestsUI currentPlugin selectPackages
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdateWindowTitle [
	drTestsUI pluginsDropList setSelectedItem: plugin2.
	
	self assert: drTestsUI title equals: 'Dr Tests - ' , plugin2 pluginName.
]
