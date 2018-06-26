Extension { #name : #RottenTestsSet }

{ #category : #'*DrTests-RottenTests' }
RottenTestsSet >> asResultsForDrTests [
	^ (self rottenTests groupedBy: #class) associations
		collect: [ :association |
			association head asResultForDrTest
				subResults: (association tail collect: #asResultForDrTests) ]
]
