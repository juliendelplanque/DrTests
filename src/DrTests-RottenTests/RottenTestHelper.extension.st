Extension { #name : #RottenTestHelper }

{ #category : #'*DrTests-RottenTests' }
RottenTestHelper class >> asResultForDrTest [
	^ DTResultGroup new
		name: 'Rotten Helpers';
		yourself
]

{ #category : #'*DrTests-RottenTests' }
RottenTestHelper >> drTestsName [
	^ 'Helper ' , super drTestsName
]
