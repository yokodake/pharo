Class {
	#name : #Counter,
	#superclass : #Object,
	#instVars : [
		'counter',
		'mutex'
	],
	#category : #'META-LAB'
}

{ #category : #'as yet unclassified' }
Counter class >> read [
	self shouldBeImplemented.
]

{ #category : #'actions api' }
Counter >> decrement [
	counter := counter - 1
]

{ #category : #'actions api' }
Counter >> get [
	| i |
	i := self read .
	self decrement .
	^ i .
]

{ #category : #'actions api' }
Counter >> increment [
	counter := counter + 1
]

{ #category : #initialization }
Counter >> initialize [
	counter := 0.
	mutex := Mutex new
]

{ #category : #'as yet unclassified' }
Counter >> mutex [
	^ mutex
]

{ #category : #'actions api' }
Counter >> read [
	^ counter
]

{ #category : #'actions api' }
Counter >> value [
	^ counter
]
