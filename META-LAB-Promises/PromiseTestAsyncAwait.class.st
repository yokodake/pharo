Class {
	#name : #PromiseTestAsyncAwait,
	#superclass : #TestCase,
	#category : #'META-LAB-Promises'
}

{ #category : #tests }
PromiseTestAsyncAwait >> testAsyncAwait [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	self
		assert: tmp1 asyncAwait equals: 2;
		assert: tmp1 value equals: 2
]

{ #category : #tests }
PromiseTestAsyncAwait >> testAsyncAwaitAfterPromiseIsResolved [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	1 second wait.
	self
		assert: tmp1 asyncAwait equals: 2;
		assert: tmp1 value equals: 2
]
