Class {
	#name : #CommentsToTestsTest,
	#superclass : #TestCase,
	#category : #'DrTests-Tests'
}

{ #category : #tests }
CommentsToTestsTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	

]

{ #category : #tests }
CommentsToTestsTest >> testErrorComment [
	| stringComment commentTestCase |
	stringComment := '(1+3)+6/0>>>4'.
	commentTestCase := CommentTestCase
		comment: stringComment
		class: self class
		selector: self selector.
	self
		assert: commentTestCase currentValue
		equals: commentTestCase expectedValue
]

{ #category : #tests }
CommentsToTestsTest >> testMultipleComments [
	| stringComment commentTestCase |
	stringComment := '(1+3)>>>4'.
	commentTestCase := CommentTestCase
		comment: stringComment
		class: self class
		selector: self selector.
	self
		assert: commentTestCase currentValue
		equals: commentTestCase expectedValue
]

{ #category : #tests }
CommentsToTestsTest >> testOneComment [
	| stringComment commentTestCase |
	stringComment := '(1+3)>>>4'.
	commentTestCase := CommentTestCase
		comment: stringComment
		class: self class
		selector: self selector.
	self
		assert: commentTestCase currentValue
		equals: commentTestCase expectedValue
]

{ #category : #tests }
CommentsToTestsTest >> testSimpleComment [
|stringComment class method commentTestCase|
stringComment:= '(1+3)>>>4'.
commentTestCase:= CommentTestCase comment: stringComment class: class selector: method.
]
