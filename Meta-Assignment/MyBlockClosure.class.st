Class {
	#name : #MyBlockClosure,
	#superclass : #Object,
	#instVars : [
		'block',
		'handlers'
	],
	#category : #'Meta-Assignment'
}

{ #category : #'as yet unclassified' }
MyBlockClosure class >> withBlock: aBlockClosure [
	^ MyBlockClosure new
		block: aBlockClosure;
		yourself
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> block: aBlockClosure [ 
	block := aBlockClosure
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> findMostSpecific: anException [
	| ex |
	ex := anException class.
	[ ex superclass = Exception | (handlers includesKey: ex) ]
		whileFalse: [ ex := ex superclass ].
	^ handlers at: ex ifAbsent: nil
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> handle: anExceptionClass with: aBlockClosure [
	handlers add: (anExceptionClass -> aBlockClosure)
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> initialize [
	handlers := {} asDictionary.
	block := []
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> value [
	^ self valueWithArguments: #()
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> value: aValue [
	^ self valueWithArguments: { aValue } asArray.
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> value: aValue value: otherValue [
	^ self
		valueWithArguments:
			{aValue.
			otherValue} asArray
]

{ #category : #'as yet unclassified' }
MyBlockClosure >> valueWithArguments: anArray [
	^ [ block valueWithArguments: anArray ]
		on: Exception
		do: [ :ex | 
			(self findMostSpecific: ex)
				ifNotNil: [ :h | h value: ex ]
				ifNil: [ ex pass ] ]
]
