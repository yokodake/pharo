Class {
	#name : #Promise,
	#superclass : #Object,
	#instVars : [
		'block',
		'value',
		'process',
		'andthen',
		'resolved',
		'mutex'
	],
	#category : #'META-LAB-Promises'
}

{ #category : #'initialize-release' }
Promise class >> withBlock: aBlock [
	| promise |
	promise := Promise new .
	promise block: (aBlock numArgs = 0 ifTrue: [[:i | aBlock value]] ifFalse: [ aBlock ]). 
	^ promise
  
]

{ #category : #'as yet unclassified' }
Promise >> asyncAwait [
	| s |
	s := Semaphore new.
	self whenResolved: [ :v | s signal ].
	s wait.
	^ self value
]

{ #category : #'as yet unclassified' }
Promise >> block: aBlock [
	block := aBlock .
	resolved := false .
]

{ #category : #'as yet unclassified' }
Promise >> initialize [
	block := [  ].
	value := nil.
	andthen := nil.
	resolved := false.
	mutex := Mutex new .
]

{ #category : #'as yet unclassified' }
Promise >> process [
	^ process
]

{ #category : #'as yet unclassified' }
Promise >> start [
	^ self start: nil
]

{ #category : #'as yet unclassified' }
Promise >> start: arg1 [
	process := [ 
		value := block value: arg1.
		mutex critical: [ 
			resolved := true . 
			andthen isNotNil
				ifTrue: [ andthen start: value ] ] ] fork
]

{ #category : #'as yet unclassified' }
Promise >> value [
	^ value
]

{ #category : #'as yet unclassified' }
Promise >> whenResolved: aBlock [
	| old |
	mutex critical: [ 
		old := andthen .
		andthen := old isNil
					  	ifTrue: [ Promise withBlock: aBlock ]
						ifFalse: [ Promise withBlock: [:v | old start:v; whenResolved: aBlock ]] .
		resolved ifTrue: [ andthen start: value ] 
	].
	^ andthen
]
