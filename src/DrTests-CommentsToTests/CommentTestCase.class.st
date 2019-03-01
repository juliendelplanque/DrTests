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
	#category : #'DrTests-CommentsToTests'
}

{ #category : #'as yet unclassified' }
CommentTestCase class >> comment: stringComment class: aClass selector: aSymbol [
	| result |
	result := [ Smalltalk compiler evaluate: stringComment ]
		on: Exception
		do: [ ^ self errorComment: stringComment class: aClass selector: aSymbol ].
	(result isKindOf: Association)
		ifFalse: [ ^ self errorComment: stringComment class: aClass selector: aSymbol ]
		ifTrue: [ ^ self new
				expression: stringComment;
				expectedValue: result key;
				currentValue: result value;
				setTestSelector: #testIt;
				classExample: aClass;
				selectorExample: aSymbol;
				yourself ]
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
		yourself
]

{ #category : #accessing }
CommentTestCase >> drTestsBrowse [
	Smalltalk tools browser
		openOnClass: classExample
		selector: selectorExample
]

{ #category : #accessing }
CommentTestCase >> testError [
	self error:'syntax error on the comment'
]
