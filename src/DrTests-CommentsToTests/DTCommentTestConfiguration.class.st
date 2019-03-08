Class {
	#name : #DTCommentTestConfiguration,
	#superclass : #DTPluginConfiguration,
	#category : #'DrTests-CommentsToTests'
}

{ #category : #converting }
DTCommentTestConfiguration >> asTestSuite [
	| suite |
	suite := TestSuite new.
	suite := TestSuite named: 'Test Generated From Comments'.
	self items
		reject: #isAbstract
		thenDo: [ :c | 
			c methods
				do: [ :m | 
					(m methodClass commentsAt: m selector)
						do: [ :com | 
							(com includesSubstring: '>>>')
								ifTrue: [ suite
										addTest: (CommentTestCase comment: com class: c selector: m selector) ] ] ] ].
	^ suite
]
