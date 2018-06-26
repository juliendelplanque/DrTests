Extension { #name : #TestCase }

{ #category : #'*DrTests-TestsRunner' }
TestCase >> asResultForDrTest [
	^ DTResult content: self
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestsName [
	^ self asString
]
