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
|stringComment class method commentTestCase|
stringComment:= '(1+3)+6/0>>>4'.
class := self class.
method:= #testErrorComment.
commentTestCase:= CommentTestCase errorComment: stringComment class: class selector: method.
self assert: commentTestCase testIt. 

self halt.
]

{ #category : #tests }
CommentsToTestsTest >> testOneComment [
	| stringComment class method commentTestCase |
	stringComment := '(1+3)>>>4'.
	class := self class.
	method := #testOneComment.
	commentTestCase := CommentTestCase
		comment: stringComment
		class: class
		selector: method.
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
