Class {
	#name : #DrTestsCommandLine,
	#superclass : #Object,
	#category : #'DrTests-Clap'
}

{ #category : #'command line' }
DrTestsCommandLine class >> drTests [
	<commandline>
	^ (ClapCommand withName: 'drtests')
		description: 'Interact with Dr Tests, the user-interface for testing Pharo projects.';
		add: ClapFlag forHelp;
		add: self testsRunner;
		add: self testsProfiler;
		add: self testsCoverage;
		yourself
]

{ #category : #'command line' }
DrTestsCommandLine class >> testsCoverage [
	^ (ClapCommand withName: 'coverage')
		description: 'Computes coverage of unit tests, TODO';
		yourself
]

{ #category : #'command line' }
DrTestsCommandLine class >> testsProfiler [
	^ (ClapCommand withName: 'profile')
		description: 'Profile unit tests, TODO';
		yourself
]

{ #category : #'command line' }
DrTestsCommandLine class >> testsRunner [
	^ (ClapCommand withName: 'run')
		description: 'Run unit tests, TODO';
		add: ((ClapFlag withName: 'junit-xml-output') description: 'Output the test results in a junit compatible format');
		add: ((ClapFlag withName: 'fail-on-failure') description: 'Exit with error code 1 if a test leads to an error or failure');
		add: ((ClapFlag withName: 'fail-on-error') description: 'Exit with error code 1 if a test leads to an error');
		add: ((ClapFlag withName: 'save') description: 'Save the image once tests have been executed');
		add: ((ClapFlag withName: 'stage-name')
					description: 'Add a prefix to the xml generated, this is useful when running in the CI infrastructure';
					add: (ClapPositional withName: 'NAME');
					yourself);
		add: ((ClapPositional withName: 'package') description: 'A String matching a package name');
		yourself
]
