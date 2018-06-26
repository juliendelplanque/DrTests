Extension { #name : #RottenTestImplementedInTrait }

{ #category : #'*DrTests-RottenTests' }
RottenTestImplementedInTrait >> drTestsName [
	^ String streamContents: [ :s |
		self compiledMethod origin printOn: s.
		s
			<< '>>#';
			<< super drTestsName;
			<< $[.
		self traitUsersInWhichTestIsRotten size printOn: s.
		s << $] ]
]
