Class {
	#name : #Promise,
	#superclass : #Object,
	#instVars : [
		'block',
		'value',
		'process',
		'onSuccess',
		'resolved',
		'mutex',
		'onFailure'
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
	onSuccess := nil.
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
		value := [block value: arg1] 
						on: Error 
						do: onFailure.
		mutex critical: [ 
			resolved := true . 
			onSuccess isNotNil
				ifTrue: [ onSuccess start: value ] ] ] fork
]

{ #category : #'as yet unclassified' }
Promise >> value [
	^ resolved ifTrue: [ value ] ifFalse: [ PromiseNotResolved signal ]
]

{ #category : #'as yet unclassified' }
Promise >> whenResolved: aBlock [
	| old |
	mutex critical: [ 
		old := onSuccess .
		onSuccess := old isNil
					  	ifTrue: [ Promise withBlock: aBlock ]
						ifFalse: [ Promise withBlock: [:v | old start:v; whenResolved: aBlock ]] .
		resolved ifTrue: [ onSuccess start: value ] 
	].
	^ onSuccess
]

{ #category : #'as yet unclassified' }
Promise >> whenResolved: aBlock whenFailed: aFailBlock [
	mutex critical: [ 
		onFailure := aFailBlock ].
	^ self whenResolved: aBlock
]
