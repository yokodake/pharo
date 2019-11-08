Class {
	#name : #PromiseTestWhenResolved,
	#superclass : #TestCase,
	#category : #'META-LAB-Promises'
}

{ #category : #tests }
PromiseTestWhenResolved >> testWhenResolvedIsTriggered [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1 whenResolved: [ :arg1 | tmp2 signal ].
	tmp2 wait.
	self assert: true
]

{ #category : #tests }
PromiseTestWhenResolved >> testWhenResolvedIsTriggeredImmediatelyWhenPromiseIsResolved [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	100 milliSeconds wait.
	self assert: tmp1 value equals: 2.
	tmp3 := tmp1 whenResolved: [ :arg1 | tmp2 signal ].
	tmp2 wait.
	self assert: tmp3 value class equals: Semaphore
]

{ #category : #tests }
PromiseTestWhenResolved >> testWhenResolvedIsTriggeredTwiceTogether [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1 whenResolved: [ :arg1 | tmp2 signal ].
	tmp4 := tmp1 whenResolved: [ :arg2 | tmp2 signal ].
	tmp2
		wait;
		wait.
	self assert: true
]

{ #category : #tests }
PromiseTestWhenResolved >> testWhenResolvedIsTriggeredTwiceWhenChained [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1 whenResolved: [ :arg1 | tmp2 signal ].
	tmp4 := tmp3 whenResolved: [ :arg2 | tmp2 signal ].
	tmp2
		wait;
		wait.
	self assert: true
]

{ #category : #tests }
PromiseTestWhenResolved >> testWhenResolvedReturnsAPromise [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1 whenResolved: [ :val | tmp2 signal ].
	self assert: tmp3 class equals: Promise
]
