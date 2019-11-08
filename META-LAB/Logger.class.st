Class {
	#name : #Logger,
	#superclass : #nil,
	#instVars : [
		'object',
		'logs',
		'sc'
	],
	#category : #'META-LAB'
}

{ #category : #'instance creation' }
Logger class >> on: arg1 [
	| tmp1 |
	tmp1 := Logger new.
	tmp1 object: arg1.
	^ tmp1
]

{ #category : #'reflective operations' }
Logger >> doesNotUnderstand: aMessage [
  logs add: aMessage .
  ^ aMessage sendTo: object
  
]

{ #category : #'as yet unclassified' }
Logger >> initialize [
	logs := OrderedCollection new
]

{ #category : #'as yet unclassified' }
Logger >> log: aMessage [
	self logs add: Message
]

{ #category : #accessing }
Logger >> logs [
  ^ logs
]

{ #category : #'as yet unclassified' }
Logger >> object: aCounter [ 
	object := aCounter
]

{ #category : #'as yet unclassified' }
Logger >> sc [
 ^sc
]

{ #category : #'as yet unclassified' }
Logger >> sc: anObject [
  ^ self = anObject
]
