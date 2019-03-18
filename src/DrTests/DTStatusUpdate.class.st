"
Notify when executing an analisis.
"
Class {
	#name : #DTStatusUpdate,
	#superclass : #Announcement,
	#instVars : [
		'message'
	],
	#category : #DrTests
}

{ #category : #'instance creation' }
DTStatusUpdate class >> message: aString [
	^ self new
		message: aString;
		yourself
]

{ #category : #accessing }
DTStatusUpdate >> message [
	^ message
]

{ #category : #accessing }
DTStatusUpdate >> message: anObject [
	message := anObject
]
