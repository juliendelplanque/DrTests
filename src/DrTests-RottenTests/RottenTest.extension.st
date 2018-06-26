Extension { #name : #RottenTest }

{ #category : #'*DrTests-RottenTests' }
RottenTest class >> asResultForDrTest [
	^ DTResultGroup new
		name: 'Rotten Tests';
		yourself
]

{ #category : #'*DrTests-RottenTests' }
RottenTest >> asResultForDrTests [
	^ DTResult content: self
]

{ #category : #'*DrTests-RottenTests' }
RottenTest >> drTestsName [
	^ self compiledMethod printString
]
