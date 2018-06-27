Extension { #name : #TestCase }

{ #category : #'*DrTests-TestsRunner' }
TestCase >> asResultForDrTest [
	^ DTResult content: self
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestBrowse [
	Smalltalk tools browser openOnClass: self class selector: self selector
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestsName [
	^ self asString
]
