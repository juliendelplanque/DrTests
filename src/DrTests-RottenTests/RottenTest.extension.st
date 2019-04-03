Extension { #name : #RottenTest }

{ #category : #'*DrTests-RottenTests' }
RottenTest >> asResultForDrTest [
	^ DTResult content: self
]

{ #category : #'*DrTests-RottenTests' }
RottenTest >> drTestsBrowse [
	Smalltalk tools browser openOnClass: self compiledMethod methodClass selector: self compiledMethod selector
]

{ #category : #'*DrTests-RottenTests' }
RottenTest >> drTestsName [
	^ self compiledMethod methodClass name , '>>#' , self compiledMethod selector
]
