Class {
	#name : #PromiseTestBasic,
	#superclass : #TestCase,
	#category : #'META-LAB-Promises'
}

{ #category : #tests }
PromiseTestBasic >> testPromiseCreatesAPromise [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	self assert: tmp1 class equals: Promise
]

{ #category : #tests }
PromiseTestBasic >> testPromiseReturnsValueAfterWaiting [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	50 milliSeconds wait.
	self assert: tmp1 value equals: 2
]

{ #category : #tests }
PromiseTestBasic >> testPromiseSpawnsAProcess [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	self assert: tmp1 process class equals: Process
]
