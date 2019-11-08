Class {
	#name : #PromiseTestFailures,
	#superclass : #TestCase,
	#category : #'META-LAB-Promises'
}

{ #category : #tests }
PromiseTestFailures >> testFailedWhenResolvedCallsHandler [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 / 0 ] promise.
	tmp3 := tmp1 whenResolved: [ :arg1 | 1 ] whenFailed: [ tmp2 signal ].
	tmp2 wait.
	self assert: true
]

{ #category : #tests }
PromiseTestFailures >> testPromiseNotFinishedthrowsException [
	| tmp1 |
	tmp1 := [ 1 + 1 ] promise.
	self should: [ tmp1 value ] raise: PromiseNotResolved
]

{ #category : #tests }
PromiseTestFailures >> testValueWhenResolvedPromiseThrowsError [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1 whenResolved: [ :arg1 | tmp2 signal ].
	self should: [ tmp3 value ] raise: PromiseNotExecutable
]

{ #category : #tests }
PromiseTestFailures >> testWhenResolvedWhenFailedReturnsPromise [
	| tmp1 tmp2 tmp3 |
	tmp2 := Semaphore new.
	tmp1 := [ 1 + 1 ] promise.
	tmp3 := tmp1
		whenResolved: [ :arg1 | tmp2 signal ]
		whenFailed: [ tmp2 signal ].
	tmp2 wait.
	self assert: tmp3 value class equals: Semaphore
]
