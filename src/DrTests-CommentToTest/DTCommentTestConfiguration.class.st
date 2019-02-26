Class {
	#name : #DTCommentTestConfiguration,
	#superclass : #DTTestsConfiguration,
	#category : #'DrTests-CommentToTest'
}

{ #category : #converting }
DTCommentTestConfiguration >> asTestSuite [
	| suite |
	suite := TestSuite new.
	suite := TestSuite named:'Test Generated From Comments'.
	self testClasses reject: #isAbstract thenDo: [ :c | c methods do: [ 
			:m | (m methodClass commentsAt: m selector) do: [ :com| 
				(com includesSubstring: '>>>') ifTrue: [  
				suite addTest: (CommentTestCase comment: com class: c selector: (m selector))].
				 ]]	
		 ].
	^ suite
]
