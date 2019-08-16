Class {
	#name : #DTTestResultType,
	#superclass : #Object,
	#category : #'DrTests-TestsRunner'
}

{ #category : #factory }
DTTestResultType class >> error [
	^ DTError new
]

{ #category : #factory }
DTTestResultType class >> fail [
	^ DTFail new
]

{ #category : #factory }
DTTestResultType class >> pass [
	^ DTPass new
]

{ #category : #factory }
DTTestResultType class >> skipped [
	^ DTSkipped new
]