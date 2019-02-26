Class {
	#name : #CommentTestCase,
	#superclass : #TestCase,
	#instVars : [
		'currentValue',
		'expectedValue',
		'expression',
		'classExample',
		'selectorExample'
	],
	#category : #'DrTests-CommentToTest'
}

{ #category : #'as yet unclassified' }
CommentTestCase class >> comment: stringComment class: aClass selector: aSymbol [
    |result|
    result := [Smalltalk compiler evaluate: stringComment] on: Error do:[ ^ self errorComment: stringComment class: aClass selector: aSymbol].
    ^ self new 
							expression: stringComment;
                        expectedValue: result key; 
                        currentValue: result value;
								setTestSelector: #testIt;
								classExample: aClass;
								selectorExample: aSymbol;
                        yourself.
]

{ #category : #'as yet unclassified' }
CommentTestCase class >> errorComment: stringComment class: aClass selector: aSymbol [
	^ self new 
							expression: stringComment;
							setTestSelector: #testError;
							classExample: aClass;
                        expectedValue: nil; 
                        currentValue: nil;
							selectorExample: aSymbol;
                        yourself.
]

{ #category : #accessing }
CommentTestCase >> classExample [
	^ classExample
]

{ #category : #accessing }
CommentTestCase >> classExample: anObject [
	classExample := anObject
]

{ #category : #accessing }
CommentTestCase >> cleanUpInstanceVariables [
	"self class allInstVarNames do: [ :name |
		name = 'testSelector' ifFalse: [
			self instVarNamed: name put: nil ] ]"
]

{ #category : #accessing }
CommentTestCase >> currentValue [
	^ currentValue
]

{ #category : #accessing }
CommentTestCase >> currentValue: anObject [
	currentValue := anObject
]

{ #category : #accessing }
CommentTestCase >> drTestsBrowse [
	Smalltalk tools browser openOnClass: classExample  selector: selectorExample
]

{ #category : #accessing }
CommentTestCase >> drTestsName [
	^ self asString
]

{ #category : #accessing }
CommentTestCase >> expectedValue [
	^ expectedValue
]

{ #category : #accessing }
CommentTestCase >> expectedValue: anObject [
	expectedValue := anObject
]

{ #category : #accessing }
CommentTestCase >> expression [
	^ expression
]

{ #category : #accessing }
CommentTestCase >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
CommentTestCase >> initialize [
	super initialize.
]

{ #category : #accessing }
CommentTestCase >> printString [
	^ expression
]

{ #category : #accessing }
CommentTestCase >> selectorExample [
	^ selectorExample
]

{ #category : #accessing }
CommentTestCase >> selectorExample: anObject [
	selectorExample := anObject
]

{ #category : #accessing }
CommentTestCase >> testError [
	self error:'syntax error on the comment'
]

{ #category : #accessing }
CommentTestCase >> testIt [
self assert: expectedValue equals: currentValue
]
