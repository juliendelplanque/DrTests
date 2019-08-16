"
I build a tree with the testsResult listed in groups: 
-Errors
-Failures
-Skipped tests
-Passed test
I am used in DrTestsUI to show the results in a orderly manner.
"
Class {
	#name : #DTTestsRunnerResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'testsResult'
	],
	#category : #'DrTests-TestsRunner'
}

{ #category : #accessing }
DTTestsRunnerResult >> buildDictionaryWitClassAsKeys: anOrderedColletion [
	| dictionary keys aux |
	keys := Set new.
	dictionary := Dictionary new.
	keys := anOrderedColletion collect: [ :each | each class ].
	keys
		do: [ :k | 
			aux := anOrderedColletion select: [ :t | t class = k ].
			dictionary add: k -> aux ].
	^ dictionary
]

{ #category : #accessing }
DTTestsRunnerResult >> buildTreeForUI [
	<dTTestRunnerResultTreeNamed: 'Grouped by type of result'>
	^ DTTreeNode new
		subResults:
			{(DTTreeNode new
				name: 'Errors';
				subResults: (self testsResult errors collect: [ :res | 
					res asResultForDrTest
						type: DTTestResultType error;
						yourself ]);
				yourself).
			(DTTreeNode new
				name: 'Failures';
				subResults:
					(self testsResult failures collect: [ :res | 
					res asResultForDrTest
						type: DTTestResultType fail;
						yourself ] as: OrderedCollection);
				yourself).
			(DTTreeNode new
				name: 'Skipped tests';
				subResults: (self testsResult skipped collect: [ :res | 
					res asResultForDrTest
						type: DTTestResultType skipped;
						yourself ]);
				yourself).
			(DTTreeNode new
				name: 'Passed tests';
				subResults: (self testsResult passed collect: [ :res | 
					res asResultForDrTest
						type: DTTestResultType pass;
						yourself ]);
				yourself)};
		yourself
]

{ #category : #accessing }
DTTestsRunnerResult >> buildTreeForUIByClasses [
	<dTTestRunnerResultTreeNamed: 'Grouped by classes and type of Result'>

	| errors failures skipped passed |
	errors := self buildDictionaryWitClassAsKeys: self testsResult errors.
	failures := self
		buildDictionaryWitClassAsKeys: self testsResult failures asOrderedCollection.
	skipped := self buildDictionaryWitClassAsKeys: self testsResult skipped.
	passed := self buildDictionaryWitClassAsKeys: self testsResult passed.
	^ DTTreeNode new
		subResults:
			{(DTTreeNode new
				name: 'Errors';
				subResults: (self createLeafs: errors);
				yourself).
			(DTTreeNode new
				name: 'Failures';
				subResults: (self createLeafs: failures);
				yourself).
			(DTTreeNode new
				name: 'Skipped tests';
				subResults: (self createLeafs: skipped);
				yourself).
			(DTTreeNode new
				name: 'Passed tests';
				subResults: (self createLeafs: passed);
				yourself)};
		yourself
]

{ #category : #accessing }
DTTestsRunnerResult >> color [
	testsResult errors ifNotEmpty: [ ^ self theme dangerBackgroundColor ].
	testsResult failures ifNotEmpty: [ ^ self theme warningBackgroundColor ].
	^ self theme successBackgroundColor
]

{ #category : #accessing }
DTTestsRunnerResult >> createLeafs: aDictionary [
	"receive a dictionary and creates a Node with the name of the class and leafs with the selectors "

	| tree |
	tree := OrderedCollection new.
	aDictionary
		keysDo: [ :c | 
			tree
				add:
					(DTTreeNode new
						name: c asString;
						subResults:
							((aDictionary at: c)
								collect: [ :e | 
									DTTreeLeaf new
										content: e;
										yourself ])) ].
	^ tree
]

{ #category : #accessing }
DTTestsRunnerResult >> pragmaKey [
	^ #'dTTestRunnerResultTreeNamed:'
]

{ #category : #accessing }
DTTestsRunnerResult >> summarizeInfo [
	"Text showed in miniDrTests with info of the result "

	^ String
		streamContents: [ :s | 
			s
				print: self testsResult passed size;
				<< ' passed';
				cr;
				print: self testsResult failures size;
				<< ' failures';
				cr;
				print: self testsResult errors size;
				<< ' errors';
				cr;
				print: self testsResult skipped size;
				<< ' skipped' ]
]

{ #category : #accessing }
DTTestsRunnerResult >> testsResult [
	^ testsResult
]

{ #category : #accessing }
DTTestsRunnerResult >> testsResult: anObject [
	testsResult := anObject
]
