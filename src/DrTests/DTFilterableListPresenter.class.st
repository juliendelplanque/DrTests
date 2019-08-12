"
I am a list presenter that can be filtered.

I also have a label.
"
Class {
	#name : #DTFilterableListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'listPresenter',
		'filterTextInput',
		'initialItems',
		'labelPresenter'
	],
	#category : #'DrTests-Spec'
}

{ #category : #accessing }
DTFilterableListPresenter >> allItems [
	^ initialItems
]

{ #category : #api }
DTFilterableListPresenter >> beMultipleSelection [
	^ self listPresenter beMultipleSelection
]

{ #category : #api }
DTFilterableListPresenter >> displayBlock: aBlock [
	^ self listPresenter displayBlock: aBlock
]

{ #category : #'as yet unclassified' }
DTFilterableListPresenter >> filterList [
	"Filters the list according to the filterTextInput."
	self unselectAll.
	self listPresenter
		items:
			(initialItems
				select: [ :each | self filterString match: (self listPresenter displayBlock value: each) ])
]

{ #category : #accessing }
DTFilterableListPresenter >> filterString [
	^ String streamContents: [ :stream |
		stream nextPut: $*.
		stream nextPutAll: self filterTextInput text.
		stream nextPut: $* ]
]

{ #category : #accessing }
DTFilterableListPresenter >> filterTextInput [
	^ filterTextInput
]

{ #category : #api }
DTFilterableListPresenter >> items: items [
	initialItems := items.
	self listPresenter items: items
]

{ #category : #accessing }
DTFilterableListPresenter >> listPresenter [
	^ listPresenter
]

{ #category : #api }
DTFilterableListPresenter >> resetFilter [
	self filterTextInput text: ''.
	self listPresenter items: initialItems.
]

{ #category : #api }
DTFilterableListPresenter >> selectAll [
	^ self listPresenter selectAll
]

{ #category : #api }
DTFilterableListPresenter >> sortingBlock: aBlock [
	^ self listPresenter sortingBlock: aBlock
]

{ #category : #api }
DTFilterableListPresenter >> unselectAll [
	^ self listPresenter unselectAll
]

{ #category : #accessing }
DTFilterableListPresenter >> visibleItems [
	^ self listPresenter items
]
