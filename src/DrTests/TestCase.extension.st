Extension { #name : #TestCase }

{ #category : #'*DrTests' }
TestCase >> drTestsSuite [
	^ TestSuite new
		addTest: self;
		yourself
]
