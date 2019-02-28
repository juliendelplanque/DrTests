"
A DrTestsUITest is a test class for testing the behavior of DrTestsUI
"
Class {
	#name : #DrTestsUITest,
	#superclass : #TestCase,
	#instVars : [
		'drTestsUI'
	],
	#category : #'DrTests-Tests'
}

{ #category : #running }
DrTestsUITest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	
	drTestsUI := DrTestsUI new
]

{ #category : #tests }
DrTestsUITest >> testBrowseButton [
	
]

{ #category : #tests }
DrTestsUITest >> testButtonRunOnMultipleClassesSelected [
	
]

{ #category : #tests }
DrTestsUITest >> testButtonRunOnOneClass [
	
]

{ #category : #tests }
DrTestsUITest >> testMultipleSelectingPackagesWillUpdateTheClassesList [
	| currentPluginSelected  randomPackage newPackagesSelected classesList|
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
   newPackagesSelected  := OrderedCollection new.
	randomPackage:=(drTestsUI packagesList listItems) anyOne.
	newPackagesSelected add: randomPackage.
	drTestsUI whenPackagesSelectionChanged: newPackagesSelected   .
	classesList := (currentPluginSelected new selectClasesFrom: newPackagesSelected ).
	
	self assertCollection: drTestsUI classesList listItems hasSameElements: classesList flattened .
	
	
	
"	newPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	self deny: currentPluginSelected equals: newPluginSelected.
	
	self assertCollection: drTestsUI packagesList listItems hasSameElements: newPluginSelected new selectPackages."
]

{ #category : #tests }
DrTestsUITest >> testNoPackageSelected [
	| currentPluginSelected  currentPackage newPackageSelected classesList|
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	currentPackage := drTestsUI packagesSelected.
	classesList := drTestsUI classesList getList.
	
	
	self assertCollection: drTestsUI classesList listItems hasSameElements: #().
	currentPackage:=(drTestsUI packagesList listItems ) anyOne.
	
	
	drTestsUI pluginsDropList setSelectedItem: (drTestsUI pluginsDropList listItems \ { currentPluginSelected }) anyOne.
	
]

{ #category : #tests }
DrTestsUITest >> testSelectingPackageWillUpdateTheClassesList [
	| currentPluginSelected  randomPackage newPackagesSelected classesList|
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
   newPackagesSelected  := OrderedCollection new.
	randomPackage:=(drTestsUI packagesList listItems) anyOne.
	newPackagesSelected add: randomPackage.
	drTestsUI whenPackagesSelectionChanged: newPackagesSelected   .
	classesList := (currentPluginSelected new selectClasesFrom: newPackagesSelected ).
	
	self assertCollection: drTestsUI classesList listItems hasSameElements: classesList flattened .
	
	
	
"	newPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	self deny: currentPluginSelected equals: newPluginSelected.
	
	self assertCollection: drTestsUI packagesList listItems hasSameElements: newPluginSelected new selectPackages."
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdateCurrentPluginInstanceVariable [
	| currentPluginSelected newPluginSelected |
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	self assert: drTestsUI currentPlugin class equals: currentPluginSelected.
	
	drTestsUI pluginsDropList setSelectedItem: (drTestsUI pluginsDropList listItems \ { currentPluginSelected }) anyOne.
	
	newPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	self deny: currentPluginSelected equals: newPluginSelected.
	
	self assert: drTestsUI currentPlugin class equals: newPluginSelected .
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdatePackagesList [
	| currentPluginSelected newPluginSelected |
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	self assertCollection: drTestsUI packagesList listItems hasSameElements: currentPluginSelected new selectPackages.
	
	drTestsUI pluginsDropList setSelectedItem: (drTestsUI pluginsDropList listItems \ { currentPluginSelected }) anyOne.
	
	newPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	self deny: currentPluginSelected equals: newPluginSelected.
	
	self assertCollection: drTestsUI packagesList listItems hasSameElements: newPluginSelected new selectPackages.
]

{ #category : #tests }
DrTestsUITest >> testSelectingPluginWillUpdateWindowTitle [
	| currentPluginSelected newPluginSelected |
	currentPluginSelected := drTestsUI pluginsDropList selectedItem.
	self assert: drTestsUI title equals: 'Dr Tests - ' , currentPluginSelected pluginName.
	
	drTestsUI pluginsDropList setSelectedItem: (drTestsUI pluginsDropList listItems \ { currentPluginSelected }) anyOne.
	
	newPluginSelected := drTestsUI pluginsDropList selectedItem.
	
	self deny: currentPluginSelected equals: newPluginSelected.
	self assert: drTestsUI title equals: 'Dr Tests - ' , newPluginSelected pluginName.
]
