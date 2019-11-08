"
a shop
"
Class {
	#name : #Shop,
	#superclass : #Object,
	#instVars : [
		'phones'
	],
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
Shop >> buy: anArray [
	^ anArray
		collect: [ :e | (phones at: e ifAbsent: [ PhoneNotAvailableException signal ]) new ]
]

{ #category : #initialization }
Shop >> initialize [
	phones
		:= Dictionary new;
		at: Iphone put: 0;
		at: LGQ8 put: 0
]
