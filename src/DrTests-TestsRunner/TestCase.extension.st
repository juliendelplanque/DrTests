Extension { #name : #TestCase }

{ #category : #'*DrTests-TestsRunner' }
TestCase >> asResultForDrTest [
	^ DTTreeLeaf content: self
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestsBrowse [
	Smalltalk tools browser openOnClass: self class selector: self selector
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestsBuildContextMenu: aMenuModel [ 
	"Nothing to display yet."
]

{ #category : #'*DrTests-TestsRunner' }
TestCase >> drTestsName [
	^ self asString
]
