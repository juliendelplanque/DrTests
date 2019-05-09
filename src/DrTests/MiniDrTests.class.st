Class {
	#name : #MiniDrTests,
	#superclass : #AbstractDrTestsUI,
	#category : #DrTests
}

{ #category : #specs }
MiniDrTests class >> defaultSpec [
^ SpecBoxLayout newVertical 
add: (SpecBoxLayout newHorizontal 
add: #helpButton;

add: #switchButton;
yourself) expand: false fill: true padding: 1;
add:#startButton;
yourself.
]

{ #category : #initialization }
MiniDrTests >> initializeButtons [
	startButton := self newButton.
	startButton label: 'run';
	icon: (self iconNamed: #smallUpdate);
	color: (Color named: 'green') .
	
	switchButton := self newButton.
	switchButton icon: (self iconNamed: #tools).
	
	
	helpButton := self newButton.
	helpButton icon: (self iconNamed: #help).
]
