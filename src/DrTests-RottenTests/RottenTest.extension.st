Extension { #name : #RottenTest }

{ #category : #'*DrTests-RottenTests' }
RottenTest >> drTestsName [
	^ self compiledMethod printString
]
