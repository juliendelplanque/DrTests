Extension { #name : #CompiledMethod }

{ #category : #'*DrTests-TestCoverage' }
CompiledMethod >> asResultForDrTest [
	^ DTTreeLeaf content: self
]

{ #category : #'*DrTests-TestCoverage' }
CompiledMethod >> drTestsBrowse [
	Smalltalk tools browser openOnClass: self methodClass selector: self selector
]

{ #category : #'*DrTests-TestCoverage' }
CompiledMethod >> drTestsName [
	^ self selector asString
]